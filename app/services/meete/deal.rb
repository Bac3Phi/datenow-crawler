module Meete
  class Deal < Base
    attr_accessor :id,
                  :title,
                  :avatar,
                  :logo,
                  :percent,
                  :point,
                  :location  
    MAX_LIMIT = 12
    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def self.random(query, clear_cache)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      response = Request.where('deals', cache, query)
      deals = response.fetch('deals', []).map { |deal| Deal.new(deal) }
      [ deals, response[:errors] ]
    end

    def self.find(id)
      response = Request.get("deals/#{id}", CACHE_DEFAULTS)
      Ingredient.new(response)
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
