class ApplicationController < ActionController::Base
    include AdminsSessionHelper
    include UsersSessionHelper
end
