module ActionDispatch::Routing
  class Mapper
    def mount_routes(options = {})
      mount AnyLogin::Engine => '/any_login', :as => options[:as] || 'any_login'
    end
  end
end
