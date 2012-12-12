CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAINZBK3UCEISVY2GA',       # required
    :aws_secret_access_key  => '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',       # required
  }
  config.fog_directory  = 'nubhub'                     # required
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  #config.fog_public     = false                                   # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end