module Meete
  class Place < Base
    attr_accessor :id,
                  :name,
                  :avatar,
                  :address,
                  :districId,
                  :districName

    MAX_LIMIT = 60
    CACHE_DEFAULTS = {expires_in: 7.days, force: false}

    def self.random(query, clear_cache)
      cache = CACHE_DEFAULTS.merge({force: clear_cache})
      response = Request.where("places", cache, query)
      places = response.fetch("places", []).map { |place|
        unless place["avatar"].nil?
          place["avatar"] = "https://media.meete.co/cache/0x0/" + place["avatar"]
        end
        Place.new(place)
      }
      [places, response[:errors]]
    end

    def self.find(id)
      response = Request.get("places/#{id}", CACHE_DEFAULTS)
      unless response["avatar"].nil?
        response["avatar"] = "https://media.meete.co/cache/0x0/" + response["avatar"]
      end
      PlaceIngredient.new(response)
    end

    def initialize(args = {})
      super(args)
      ingredients = parse_ingredients(args)
      instructions = parse_instructions(args)
    end

    def parse_ingredients(args = {})
      args.fetch("extendedPlaceIngredients", []).map { |ingredient| PlaceIngredient.new(ingredient) }
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
