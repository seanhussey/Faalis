require_dependency "red_base/application_controller"

module RedBase
  class API::V1::UsersController < APIController

    def index
      @users = User.joins(:group).all
      authorize! :read, @users
      respond_with(@users)
    end

    def show
      @user = User.find(params[:id])
      authorize! :read, @user
    end

    def destroy
      ids = params[:id].split(",")
      @users = User.where(:id => ids)
      authorize! :destory, @groups
      @users.destroy_all
    end

    def update
      group = Group.find(params[:group])
      @user = User.find(params[:id])
      authorize! :update, @user
      user_fields = {
                     first_name: params[:first_name],
                     last_name: params[:last_name],
                     email: params[:email],
                     group: group,
                   }
      if params[:password]
        user_fields["password"] =  params[:password]
      end
      @user.update(user_fields)
    end

    def create
      authoriz! :create, RedBase::User
      group = Group.find(params[:group])
      if group
        @user = User.create!({
                               first_name: params[:first_name],
                               last_name: params[:last_name],
                               email: params[:email],
                               password: params[:password],
                               group: group,
                             })
      end
    end
  end
end