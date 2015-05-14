class PrimersController < ApplicationController
    def new
        render json: { foo: 3 }
    end
end
