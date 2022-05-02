require "nokogiri"
require "open-uri"

require_relative 'view'
class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Pegar todas as receitas do cookbook
    recipes = @cookbook.all

    # 2. Mandar a view mostrar as receitas
    @view.display(recipes)

  end

  def  create
    # 1. Perguntar qual o nome da receita
    name = @view.ask_recipe_name

    # 2. Perguntar qual a descrição da receita
    description = @view.ask_recipe_description

    # Perguntar a nota da receita
    rating = @view.ask_recipe_rating

    # Perguntar o tempo de preparo
    prep_time = @view.ask_prep_time

    # 3. Instanciar uma nova receita
    recipe = Recipe.new(name, description, rating, prep_time)

    # 4. Adicionar a receita ao Cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. Mostrar as receitas cadastradas
    list

    # 2. Perguntar o index da receita a ser excluída
    index = @view.ask_index

    # 3. Mandar o cookbook remover a receita pelo index
    @cookbook.remove_recipe(index)

  end

  def mark_as_done
    # Mostrar as receitas cadastradas
    list

    # Perguntar o index da receita
    index = @view.ask_index

    # Mandar o cookbook marcar a receita como done pelo index
    @cookbook.mark_as_done(index)
  end

  def import
    ingredient = @view.ask_ingredient
    url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"

    doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")

    names = doc.search('.card__title').first(5).map { |e| e.text.strip }
    links = doc.search('.card__detailsContainer .card__titleLink').first(5).map { |e| e.attributes['href'].value }

    names.each_with_index do |name, index|
      puts "#{index + 1} - #{name}"
    end
    puts "Enter recipe number to import:"
    index = gets.chomp.to_i - 1

    url = links[index]

    doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")

    name = doc.search('h1').text
    description = doc.search('.recipe-summary').text.strip
    rating = doc.search('.review-star-text').first.text.match(/\d/)[0].to_i
    prep_time = doc.search('.recipe-meta-item-body')[1].text.strip

    recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(recipe)





  end

end
