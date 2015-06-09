class PrimersController < ApplicationController
  before_filter :restrict_access

  def index
    page = if params[:page] then params[:page].to_i else 1 end

    render json: Primer.search(code: params[:code],
                               name: params[:name],
                               sequence: params[:sequence],
                               page: page)
  end

  def show
    # TODO: find by ID or code if param[:id] isn't a number
    render json: Primer.find(params[:id])
  end

  def create
    primer = Primer.new(primer_params)
    if primer.save
      render json: primer, status: :created
    else
      render json: primer.errors.full_messages, status: :conflict
      # TODO: Conflict details
    end
  end

  def update
    primer = Primer.find(params[:id])
    if primer.update(primer_params)
      render json: primer
    else
      render json: primer.errors.full_messages, status: :conflict
      # TODO: conflict details
    end
  end

  def destroy
    Primer.find(params[:id]).destroy
    render nothing: true, status: :no_content
  end

  private
    def primer_params
      params.permit(:name, :code, :sequence, :notes)
    end
end
