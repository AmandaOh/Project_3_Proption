class ListingsController < ApplicationController
  def index
    @listings = Property.where('listed > ?', 0)
  end

  def show
    @listing = Listing.find(params[:id])
    @last_bid = @listing.bids.last
    @new_bid = Bid.new

    # respond_to do |format|
    #   if @new_bid.save
    #     format.html { redirect_to listing_path, notice: 'Your bid is successfully placed.' }
    #     format.json { render :show, status: :ok, location: @new_bid }
    #   else
    #     format.html { render :show }
    #     format.json { render json: @new_bid.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  def mylistings
    @current_user_listings = current_user.owned_listings
  end

  def new
    @listing = Listing.new
    @my_properties=current_user.properties

  end

  def create
    # edit curr_property listed to 1
    # create new listing with curr_property id
    # current_user
    # debugger
    # @my_properties=current_user.properties
    # prop2.create_listing auction_date: Date.today, duration: 48, property_id: 2

    @property = Property.find(params[:property_id])
    @new_listing = Listing.new()
    @new_listing.auction_date = DateTime.now
    @new_listing.duration = DateTime.now + 3.minutes
    @new_listing.property_id = @property.id
    @new_listing.save
    @update_prop_listing =
    @property.listed = 1
    @property.save

    @new_listing.errors.full_messages

    redirect_to mylistings_path
  end

  def accept_bid
    @property = Property.find(params[:id])
    @property.listed = 3
    @property.save

  redirect_to mylistings_path
  end

end
