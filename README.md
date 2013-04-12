## Rack::Headermap

You can mount rack-based applications into rails by mean `mount App => '/path'`
in routes.rb. But you don't always have to do that this way. For example if I
had sidekiq web interface I'd rather run it standalone and then proxy all
requests using nginx. But if you'd tried to do that using rewrite perhaps you
saw that you could load just front page but all the rest links and js/css files
had wrong paths.

## Usage

    require 'rack-headermap'
    use Rack::Headermap
    run App

And add these settings to nginx:

   location /namespace {
     proxy_set_header X-Real-IP  $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_set_header Host $http_host;

     if ($request_uri ~ ^/namespace(.*)$) {
       set $xpathinfo $1;
       set $xscriptname /namespace;
     } 
     proxy_set_header X-PathInfo $xpathinfo;
     proxy_set_header X-ScriptName $xscriptname;

     proxy_pass http://namespaceapp;
   }
