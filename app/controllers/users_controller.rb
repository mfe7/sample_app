class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :newCharge, :createCharge]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
  	@user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to ticketnumber_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def school_race
    @mit_tickets = User.where(:school => 'MIT').sum('tickets_purchased') 
    @har_tickets = User.where(:school => 'Harvard').sum('tickets_purchased') 
    @wel_tickets = User.where(:school => 'Wellesley').sum('tickets_purchased') 
    @bu_tickets = User.where(:school => 'Boston Univ.').sum('tickets_purchased') 
    @bc_tickets = User.where(:school => 'Boston College').sum('tickets_purchased') 
    @ne_tickets = User.where(:school => 'Northeastern').sum('tickets_purchased') 
  end

  def newCharge
    @tix_number = params[:tickets_wanted]
    @user = current_user
    tix_string = "tickets_wanted=" + @tix_number.to_s()
    User.where(:email => @user.email).update_all(tix_string)
  end

  def createCharge
    #amount in cents
    @user = current_user
    @tix = @user.tickets_wanted
    @amount = ticket_price * @tix.to_i() * 100
    if params[:stripeToken]==nil
        @descr = 'bogus'
    else
        @descr = @amount
    end  

    @customer = Stripe::Customer.create(
      :email => @user.email,
      :card => params[:stripeToken],
      :description => @descr
      )

  end

  

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(home_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(home_path) unless current_user.admin?
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to swiped_path
end
