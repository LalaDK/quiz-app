class Game::TeamController < AdminApplicationController

  def index
    respond_to do |format|
      format.json do
        game = Game.find(params[:game_id])
        render json: game.teams
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        game = Game.find(params[:game_id])
        game.add_team(params[:name], params[:background_color])
        render json: {}
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        game = Game.find(params[:game_id])
        team = game.teams.find(params[:id])
        if team.destroy
          render json: {}
        else
          raise
        end
      end
    end
  end

end
