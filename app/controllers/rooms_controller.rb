require "opentok"
require "json"

class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_opentok

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
    @channel = Channel.find(params[:channel_id])
  end


  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @token = @opentok.generate_token @room.session_id, { name: current_user.name }
    @opentok

    begin
      info = @opentok.streams.all(@room.session_id)
    rescue
    ensure
      if info
        arr = []
        info.each do |stream|
          jinfo = JSON.parse(stream.to_json)
          username = jinfo["name"]
          user = User.find_by(username: username)
          arr.push(user)
        end
        @streams = arr
      else
        @streams = []
      end
    end
  end

  # GET /rooms/new
  def new
    @channel = Channel.find(params[:channel_id])
    @room = @channel.rooms.build
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @channel = Channel.find(params[:channel_id])
    @room = @channel.rooms.build(room_params)
    @session = @opentok.create_session
    @room.session_id = @session.session_id

    respond_to do |format|
      if @room.save
        format.html { redirect_to channel_room_path(@room.channel, @room), notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to channel_room_path(@room.channel, @room), notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to channel_rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :description, :channel_id, :vonage_session)
    end

    def set_opentok
      @opentok = get_opentok
    end
end
