#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>

#include "ece356_lab2.h"


server_t myServer;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;


/*
 *  Print error message and fail.
 */
void error(const char* message) {
    perror(message);
    exit(1);
}


/*
 *  Add newly created client to client linked list
 */
void add_client(client_t *client) {

    client_t *current = myServer.first_client;
    if (current == NULL) {
        myServer.first_client = client;
        return;
    } while (current->next_client != NULL) {
        current = current->next_client;
    }
    current->next_client = client;
}


/*
 *  Add newly created client to client linked list
 */
void add_chatroom_client(client_t *creator, client_t *client) {

    client_t *current = creator->next_room_member;
    if (current == NULL) {
        creator->next_room_member = malloc(sizeof(client));
        creator->next_room_member->accept_fd = client->accept_fd;
        strcpy(creator->next_room_member->name, client->name);
        return;
    } while (current->next_room_member != NULL) {
        current = current->next_room_member;
    }
    current->next_room_member = malloc(sizeof(client));
    current->next_room_member->accept_fd = client->accept_fd;
    strcpy(current->next_room_member->name, client->name);
}


/*
 *  Remove client from linked list when client disconnects
 *  from server
 */
void remove_client(client_t *client) {

    client_t *current = myServer.first_client;
    client_t *prev = NULL;
    while (current != NULL) {
        if (current == client) {
            if (prev == NULL) {
                myServer.first_client = current->next_client;
                free(client);
                break;
            } else {
                prev->next_client = current->next_client;
                free(client);
                break;
            }
        } else {
            prev = current;
            current = current->next_client;
        }
    }
}


/*
 *  Remove client from linked list when client disconnects
 *  from server
 */
void remove_chatroom_client(client_t *creator, client_t *client) {

    client_t *current = creator->next_room_member;
    client_t *prev = NULL;
    while (current != NULL) {
        if (current == client) {
            if (prev == NULL) {
                creator->next_room_member = current->next_client;
                free(client);
                break;
            } else {
                prev->next_room_member = current->next_room_member;
                free(client);
                break;
            }
        } else {
            prev = current;
            current = current->next_room_member;
        }
    }
}


/*
 *  Find client in linked list given client name
 *  Returns NULL when client not found
 */
struct client *find_client(char *client_name) {

    client_t *current = myServer.first_client;
    while (current != NULL) {
        if (!strcmp(current->name, client_name)) {
            return current;
        } else {
            current = current->next_client;
        }
    }
    return NULL;
}


/*
 *  Wrapper method for clearing send buffer
 */
void clear_send_buffer() {
    bzero(myServer.send_buffer, MAX_MSG_SIZE);
}


/*
 *  Wrapper method for clearing receive buffer
 */
void clear_recv_buffer() {
    bzero(myServer.recv_buffer, MAX_MSG_SIZE);
}


/*
 *  Wrapper method for sending messages to client
 *  Up to the caller when to clear the send buffer
 */
void server_send(int client_fd) {
    int status = send(client_fd, myServer.send_buffer, strlen(myServer.send_buffer), 0);
    clear_send_buffer();
    if (status < 0) {
        error("ERROR on send");
    }
}


/*
 *  Wrapper method for receiving messages from clients
 *  This method calls a blocking recv()
 */
void server_recv_blocking(int client_fd) {
    clear_recv_buffer();
    int status = recv(client_fd, myServer.recv_buffer, MAX_MSG_SIZE, 0);
    if (status < 0) {
        error("ERROR on recv");
    }
}


/*
 *  Wrapper method for receiving messages from clients
 *  This method calls a non-blocking recv()
 */
int server_recv_nonblocking(int client_fd) {
    clear_recv_buffer();
    return recv(client_fd, myServer.recv_buffer, MAX_MSG_SIZE, MSG_DONTWAIT);
}


/*
 *  Extract information from client messages
 *  Expects messages of the format INFO: info1: info2
 *  INFO can be thought of as a tag and
 *  info1 and 2 as the desired information
 */
char **parse_info(char *msg) {

    char **all_info = malloc(sizeof(char)); // Need something allocated to get started
    char *info = strtok(msg, DELIMITER);
    int info_num = 0;

    while ((info = strtok(NULL, DELIMITER)) != NULL) {
        ++info_num;
        all_info = realloc(all_info, sizeof(all_info)*info_num);
        all_info[info_num] = info;
    }
    char *len = malloc(sizeof(len)*100);
    sprintf(len, "%d", info_num);
    all_info[0] = len;
    return all_info;
}


/*
 *  Initialize server
 *  Use TCP - SOCK_STREAM
 */
void initialize_server() {

    myServer.listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (myServer.listen_fd < 0) {
        error("ERROR on socket");
    }

    // Set up server structure
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = INADDR_ANY;
    server_address.sin_port = htons(SERVER_PORT);
    myServer.addr = server_address;

    if (bind(myServer.listen_fd, (struct sockaddr *) &myServer.addr,
                sizeof(myServer.addr)) < 0) {
        error("ERROR on bind");
    }

    if (listen(myServer.listen_fd, SOMAXCONN) < 0) { // SOMAXCONN = 128
        error("ERROR on listen");
    }
}


/*
 *  Send list of all clients and their file descriptors to
 *  the requesting client
 */
void send_client_list(client_t *current) {

    strcpy(myServer.send_buffer, "ONLINE USERS:\n");
    client_t *client = myServer.first_client;

    while (client != NULL) {
        if (client->name != NULL) {
            sprintf(myServer.send_buffer, "%s%s - %d\n",
                    myServer.send_buffer, client->name, client->accept_fd);
        }
        client = client->next_client;
    }
    server_send(current->accept_fd);
}


/*
 *  Send message from one connected client to the other
 */
void handle_connected_client_response(client_t *asker, client_t *receiver) {
    sprintf(myServer.send_buffer, "%s: %s", asker->name, myServer.recv_buffer);
    server_send(receiver->accept_fd);
}


/*
 *  Main loop for handling client to client communication
 */
void *Connect_client_to_client(void *arg) {

    client_t **clients = (client_t **) arg;
    client_t *asker, *receiver;
    asker = clients[0];
    receiver = clients[1];
    int status;

    printf("Connected %s to %s\n", asker->name, receiver->name);

    while(1) {
        pthread_mutex_lock(&mutex);
        clear_recv_buffer();
        status = server_recv_nonblocking(asker->accept_fd);

        if (status == 0) {
            pthread_mutex_unlock(&mutex);
            break;
        }

        // Client wants to disconnect from other client
        if (!(strcmp(myServer.recv_buffer, "3"))) {
            pthread_mutex_unlock(&mutex);
            break;
        }
        if (strlen(myServer.recv_buffer) > 0) {
            handle_connected_client_response(asker, receiver);
        }
        pthread_mutex_unlock(&mutex);
    }
    pthread_exit(NULL);
}


void send_message_to_room_members(client_t *current) {

    client_t *member = current->next_room_member;
    sprintf(myServer.send_buffer, "%s: %s", current->name, myServer.recv_buffer);
    while (member != NULL) {
        send(member->accept_fd, myServer.send_buffer, strlen(myServer.send_buffer), 0);
        member = member->next_room_member;
    }
    clear_send_buffer();
}


int is_client_name(char *name) {

    client_t *current = myServer.first_client;
    while (current != NULL) {
        if (!strcmp(current->name, name)) {
            return 1;
        }
        current = current->next_client;
    }
    return 0;
}


char *create_list_of_room_members(client_t *creator) {

    client_t *room_member = creator->next_room_member;
    char *room_list = malloc(sizeof(room_list)*strlen(creator->name));
    strcpy(room_list, creator->name);
    while (room_member != NULL) {
        room_list = realloc(room_list,
                sizeof(room_list)+sizeof(room_member->name)+sizeof(DELIMITER));
        strcat(room_list, DELIMITER);
        strcat(room_list, room_member->name);
        room_member = room_member->next_room_member;
    }
    return room_list;

}


/*
 *  Tell a client that another client is trying to connect with him/her
 */
void notify_receiver(client_t *asker, client_t *receiver) {
    sprintf(myServer.send_buffer, "%s: %s", "CONNECTING", asker->name);
    server_send(receiver->accept_fd);
}


/*
 *  Close the receiver side of the connection after the client
 *  on the other side has closed his/her side.
 */
void disconnect_receiver(client_t *asker, client_t *receiver) {
    sprintf(myServer.send_buffer, "%s: %s", "LEAVING", asker->name);
    server_send(receiver->accept_fd);
}


/*
 *  Controller logic for establishing and closing a connection
 *  between clients.
 */
void *Connect_clients(void *arg) {

    pthread_t pth;
    client_t **clients = (client_t **) arg;
    client_t *one = clients[0];
    client_t *two = clients[1];

    client_t **one_to_two = malloc(sizeof(one_to_two) * 2);
    one_to_two[0] = one;
    one_to_two[1] = two;

    pthread_create(&pth, NULL, Connect_client_to_client, one_to_two);
    notify_receiver(one, two);

    pthread_join(pth, NULL);
    disconnect_receiver(one, two);
    pthread_exit(NULL);
}


/*
 *  Wrapper method for better readability. Handle thread creation
 *  for connecting clients.
 */
void establish_connection(client_t *asker, client_t *receiver) {

    pthread_t connect_clients_thread;

    client_t **clients = malloc(sizeof(clients) * 2);
    clients[0] = asker;
    clients[1] = receiver;
    pthread_create(&connect_clients_thread, NULL, Connect_clients, clients);
    pthread_join(connect_clients_thread, NULL);
}


/*
 *  Handle client request to connect with another client.
 */
void *Query_for_connection(void *arg) {

    client_t **clients = (client_t **) arg;
    client_t *asker = clients[0];
    client_t *receiver = clients[1];
    int status;

  //  sprintf(myServer.send_buffer, "REQUEST: Who would you like to connect to?\n");
  //  server_send(asker->accept_fd);

    pthread_mutex_lock(&mutex);
    pthread_mutex_unlock(&mutex);
    printf("Connecting %s and %s\n", asker->name, receiver->name);
    establish_connection(asker, receiver);
    pthread_exit(NULL);
}


/*
 *  Wrapper method for better readability. Handle thread
 *  creation for querying for a client to client connection.
 */
void handle_connection_request(client_t *current) {

    char **msg_info = parse_info(myServer.recv_buffer);
    char *receiver_name = msg_info[1];
    client_t *receiver = find_client(receiver_name);

    printf("NAME: %s\n", receiver_name);
    if (receiver == NULL) {
        sprintf(myServer.send_buffer, "Client not found :(\n");
        server_send(current->accept_fd);
        return;
    }
    sprintf(myServer.send_buffer, "SUCCESS: Found %s!", receiver_name);
    server_send(current->accept_fd);

    client_t **clients = malloc(sizeof(clients)*2);
    clients[0] = current;
    clients[1] = receiver;
    pthread_t pth;

    pthread_mutex_unlock(&mutex);
    pthread_create(&pth, NULL, Query_for_connection, clients);
    pthread_join(pth, NULL);
    pthread_mutex_lock(&mutex);
}


/*
 *  Wrapper method for better readability. Establish connection
 *  from receiver to asker so receiver can send messages to
 *  asker.
 */
void handle_connection_confirmation(client_t *receiver) {

    char **msg_info = parse_info(myServer.recv_buffer);
    char *asker_name = msg_info[1];
    printf("NAME: %s\n", asker_name);
    pthread_mutex_unlock(&mutex);
    client_t *asker = find_client(asker_name);
    establish_connection(receiver, asker);
    pthread_mutex_lock(&mutex);
}


/*
 *  Controller logic for handling client responses.
 */
void handle_client_response(client_t *current) {

    printf("%s: %s\n", current->name, myServer.recv_buffer);

    if (!strcmp(myServer.recv_buffer, "1")){
        send_client_list(current);
    } else if (strstr(myServer.recv_buffer, "CONNECTTO: ") != NULL) {
        handle_connection_request(current);
    } else if (strstr(myServer.recv_buffer, "CONFIRMED: ") != NULL) {
        handle_connection_confirmation(current);
    }
}


/*
 *  Main logic for communicating with client.
 */
void *Receive_messages(void *arg) {

    client_t *current;
    current = (client_t *) arg;
    int status;

    while(1) {
        pthread_mutex_lock(&mutex);
        clear_recv_buffer();
        status = server_recv_nonblocking(current->accept_fd);
        if (status == 0) {
            printf("Client %s has left.\n", current->name);
            remove_client(current);
            pthread_mutex_unlock(&mutex);
            break;
        }
        if (strlen(myServer.recv_buffer) > 0) {
            handle_client_response(current);
        }
        pthread_mutex_unlock(&mutex);
    }
    pthread_exit(NULL);
}

void create_intro_message() {
    strcpy(myServer.send_buffer, "######################################\n");
    strcat(myServer.send_buffer, "#                                    #\n");
    strcat(myServer.send_buffer, "#        ECE Instant Messenger       #\n");
    strcat(myServer.send_buffer, "#                                    #\n");
    strcat(myServer.send_buffer, "# Chat anytime, anywhere... as long  #\n");
    strcat(myServer.send_buffer, "# as it's on your localhost.         #\n");
    strcat(myServer.send_buffer, "#                                    #\n");
    strcat(myServer.send_buffer, "######################################\n");
    strcat(myServer.send_buffer, "\n");
    strcat(myServer.send_buffer, "Please enter your name: ");
}


void create_acceptance_confirmation_message() {
    strcpy(myServer.send_buffer, "\n");
    strcat(myServer.send_buffer, "SUCCESS: You are now connected to the server.\n");
    strcat(myServer.send_buffer, "\n");
    strcat(myServer.send_buffer, "What would you like to do?\n");
    strcat(myServer.send_buffer, "--------------------------\n");
    strcat(myServer.send_buffer, "  [1] See who is online.\n");
    strcat(myServer.send_buffer, "  [2] Chat with a friend.\n");
    strcat(myServer.send_buffer, "  [3] Disconnect from friend chat.\n");
    strcat(myServer.send_buffer, "  [4] Exit chat.\n");
    strcat(myServer.send_buffer, "--------------------------\n");
    strcat(myServer.send_buffer, "\n");
}



/*
 *  Primary logic for accepting clients. After client is accepted,
 *  launch thread to handle client to server communication.
 */
void accept_client() {

    client_t *current = malloc(sizeof(current));
    pthread_t receive_messages_thread;

    current->len = sizeof(current->client_addr);
    current->accept_fd = accept(myServer.listen_fd,
            (struct sockaddr *) &current->client_addr,
            &current->len);
    if (current->accept_fd < 0) {
        error("ERROR on accept.");
    }

    add_client(current); // Add client to list of clients
    create_intro_message();
    server_send(current->accept_fd);

    pthread_mutex_lock(&mutex);
    clear_recv_buffer();
    server_recv_blocking(current->accept_fd);
    client_t *dummy = find_client(myServer.recv_buffer);
    if (dummy != NULL) {
        sprintf(myServer.send_buffer, "CONFLICT: Someone already has that name.\n");
        server_send(current->accept_fd);
        pthread_mutex_unlock(&mutex);
    } else {
        strcpy(current->name, myServer.recv_buffer);
        pthread_mutex_unlock(&mutex);
        create_acceptance_confirmation_message();
        server_send(current->accept_fd);
        pthread_create(&receive_messages_thread, NULL, Receive_messages, current);
    }
}


/*
 *  Close all sockets.
 */
void close_server() {
    client_t *current = myServer.first_client;
    while (current != NULL) {
        close(current->accept_fd);
        current = current->next_client;
    }
    close(myServer.listen_fd);
}


/*
 *  Signal handler
 *  Currently only handles SIGINT to make sure to close
 *  all sockets before exiting
 */
void sig_handler(int signum) {
    if (signum == SIGINT) {
        close_server();
        exit(signum);
    }
}


int main() {
    signal(SIGINT, sig_handler);
    initialize_server();
    while(1) { accept_client(); }
    close_server();
    pthread_mutex_destroy(&mutex);
}
