###
$(window).bind('popstate', function (e) {
        if (e.originalEvent.state && e.originalEvent.state.path) {
            $.get(e.originalEvent.state.path, function(data) {
                $('#slider').slideTo(data);      
            });
            return false;
        }
        return true;
    }
###