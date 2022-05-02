class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|

      done = recipe.done? ? '[X]' : '[ ]'

      puts "#{index + 1} - #{done} #{recipe.name}: #{recipe.description} (Rating: #{recipe.rating} / 5) Time: #{recipe.prep_time}"
    end
  end

  def ask_recipe_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_recipe_description
    puts "Enter recipe description:"
    gets.chomp
  end

  def ask_recipe_rating
    puts "Enter recipe rating (0 to 5):"
    gets.chomp.to_i
  end

  def ask_prep_time
    puts "Enter preparation time:"
    gets.chomp
  end

  def ask_index
    puts "Enter recipe index:"
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "What ingredient would you like a recipe for?"
    ingredient = gets.chomp
    puts "Looking for #{ingredient} recipes on the Internet..."
    ingredient
  end
end
