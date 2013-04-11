# Browser request: http://localhost:9292/namespace/1
# PATH_INFO: /1
# SCRIPT_NAME: /namespace

# Nginx settings:
# location /namespace {
#   proxy_set_header X-Real-IP  $remote_addr;
#   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#   proxy_set_header Host $http_host;
#   if ($request_uri ~ ^/namespace(.*)$) {
#     set $xpathinfo $1;
#     set $xscriptname /namespace;
#   } 
#   proxy_set_header X-PathInfo $xpathinfo;
#   proxy_set_header X-ScriptName $xscriptname;
#   proxy_pass http://sidekiqweb;
# }
module Rack
  class Headermap
    def initialize(app)
      @app = app
    end

    def call(env)
      path = env["PATH_INFO"]
      script_name = env['SCRIPT_NAME']
      env["PATH_INFO"] = env['HTTP_X_PATHINFO']
      env['SCRIPT_NAME'] = env['HTTP_X_SCRIPTNAME']
      @app.call(env)
    ensure
      env['PATH_INFO'] = path
      env['SCRIPT_NAME'] = script_name
    end
  end
end
