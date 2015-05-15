class PrimersController < ApplicationController
  def index
    render json: Primer.order(:code)
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
      render nothing: true, status: :conflict
      # TODO: Conflict details
    end
  end

  def update
    primer = Primer.find(params[:id])
    if primer.update(primer_params)
      render json: primer
    else
      render nothing: true, status: :conflict
      # TODO: conflict details
    end
  end

  def destroy
    Primer.find(params[:id]).destroy
    render nothing: true, status: :no_content
  end

  private
    def primer_params
      params.require(:primer).permit(:name, :code, :sequence)
    end
end
