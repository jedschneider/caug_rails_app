class UsStatesController < ApplicationController
  # GET /us_states
  # GET /us_states.xml
  def index
    @us_states = UsState.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @us_states }
    end
  end

  # GET /us_states/1
  # GET /us_states/1.xml
  def show
    @us_state = UsState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @us_state }
    end
  end

  # GET /us_states/new
  # GET /us_states/new.xml
  def new
    @us_state = UsState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @us_state }
    end
  end

  # GET /us_states/1/edit
  def edit
    @us_state = UsState.find(params[:id])
  end

  # POST /us_states
  # POST /us_states.xml
  def create
    @us_state = UsState.new(params[:us_state])

    respond_to do |format|
      if @us_state.save
        flash[:notice] = 'UsState was successfully created.'
        format.html { redirect_to(@us_state) }
        format.xml  { render :xml => @us_state, :status => :created, :location => @us_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @us_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /us_states/1
  # PUT /us_states/1.xml
  def update
    @us_state = UsState.find(params[:id])

    respond_to do |format|
      if @us_state.update_attributes(params[:us_state])
        flash[:notice] = 'UsState was successfully updated.'
        format.html { redirect_to(@us_state) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @us_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /us_states/1
  # DELETE /us_states/1.xml
  def destroy
    @us_state = UsState.find(params[:id])
    @us_state.destroy

    respond_to do |format|
      format.html { redirect_to(us_states_url) }
      format.xml  { head :ok }
    end
  end
end
