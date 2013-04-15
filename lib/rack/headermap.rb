module Rack
  class Headermap
    def initialize(app)
      @app = app
    end

    def call(env)
      path = env['PATH_INFO']
      script_name = env['SCRIPT_NAME']
      if needed_x_headers_set?(env)
        env['PATH_INFO'] = env['HTTP_X_PATHINFO']
        env['SCRIPT_NAME'] = env['HTTP_X_SCRIPTNAME']
      end
      @app.call(env)
    ensure
      env['PATH_INFO'] = path
      env['SCRIPT_NAME'] = script_name
    end

    private

    def needed_x_headers_set?(env)
      env['HTTP_X_PATHINFO'] && env['HTTP_X_SCRIPTNAME']
    end
  end
end
