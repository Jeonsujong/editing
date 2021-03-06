class ManualsController < ApplicationController
  before_action :set_manual, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!

  def index
    if current_user.userspec
      @manuals = Manual.all
      sorting(@manuals)
    elsif
      @manuals = Manual.all.order("creat_at DESC")
    end
  end

  def category
    @p = params[:category]
    @manuals = Manual.where(:category => @p)
    sorting(@manuals)
  end

  def show
  end

  def new
    @manual = current_user.manuals.build
  end

  def edit
  end

  def create
    @manual = current_user.manuals.build(manual_params)

    respond_to do |format|
      if @manual.save
        format.html { redirect_to @manual, notice: 'Manual was successfully created.' }
        format.json { render :show, status: :created, location: @manual }
      else
        format.html { render :new }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manual.update(manual_params)
        format.html { redirect_to @manual, notice: 'Manual was successfully updated.' }
        format.json { render :show, status: :ok, location: @manual }
      else
        format.html { render :edit }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manual.destroy
    respond_to do |format|
      format.html { redirect_to manuals_url, notice: 'Manual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @manual.upvote_by current_user
    redirect_to :back
  end

  def sorting(manuals)
    @us= Userspec.find(current_user.id)
    @manuals = manuals
    @manualArray = Array.new(@manuals.count){Array.new(2)}
    keys = ['skintype', 'age', 'atopy', 'pimple', 'allergy', 'bb', 'lip', 'eyebrow', 'eyeline', 'color', 'skincolor']
    arrayIndex = 0

    # 매뉴얼스펙과 유저스펙 비교
    @manuals.each do |manual|
      @manualArray[arrayIndex][1] = manual.id
      @manualArray[arrayIndex][0] = 0

      for i in 0..10
        if @us[keys[i]]
          if @us[keys[i]] == manual[keys[i]]
            @manualArray[arrayIndex][0] += 1
          end
        end
      end
      arrayIndex += 1
    end

    # @manuals 재배열
    @manualArray = @manualArray.sort.reverse
    @manuals = [] #초기화
    for i in 0..(@manualArray.length-1)
      @manuals << Manual.find(@manualArray[i][1])
    end
  end

  private
  def set_manual
    @manual = Manual.find(params[:id])
  end

  def manual_params
    params.require(:manual).permit(:category, :title, :content, :skintype, :age, :atopy, :pimple, :allergy, :bb, :lip, :eyebrow, :eyeline, :color, :skincolor)
  end
end
