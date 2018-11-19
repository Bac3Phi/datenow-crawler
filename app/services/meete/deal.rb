module Meete
  class Deal < Base
    attr_accessor :id,
                  :title,
                  :avatar,
                  :logo,
                  :percent,
                  :point,
                  :locations
    MAX_LIMIT = 12
    CACHE_DEFAULTS = {expires_in: 7.days, force: false}

    def self.random(query, clear_cache)
      cache = CACHE_DEFAULTS.merge({force: clear_cache})
      response = Request.where("deals", cache, query)
      deals = response.fetch("deals", []).map { |deal|
        unless deal["avatar"].nil?
          deal["avatar"] = "https://media.meete.co/cache/0x0/" + deal.values[2]
        end
        Deal.new(deal)
      }
      [deals, response[:errors]]
    end

    def self.find(id)
      response = Request.get("deals/#{id}", CACHE_DEFAULTS)
      unless response["avatar"].nil?
        response["avatar"] = "https://media.meete.co/cache/0x0/" + response["avatar"]
      end
      Ingredient.new(response)
    end

    def self.find_places(deal_id)
      response = Request.get("deals/#{deal_id}/places", CACHE_DEFAULTS)
      unless response["avatar"].nil?
        response["avatar"] = "https://media.meete.co/cache/0x0/" + response["avatar"]
      end
      DealsIngredientPlaces.new(response)
    end

    def initialize(args = {})
      super(args)
      ingredients = parse_ingredients(args)
      instructions = parse_instructions(args)
    end

    def parse_ingredients(args = {})
      args.fetch("extendedIngredients", []).map { |ingredient| Ingredient.new(ingredient) }
    end

    def parse_instructions(args = {})
      instructions = args.fetch("analyzedInstructions", [])
      if instructions.present?
        steps = instructions.first.fetch("steps", [])
        steps.map { |instruction| Instruction.new(instruction) }
      else
        []
      end
    end
  end
end
