class QueriesController < ApplicationController

  RDF_FILE = (Rails.root.join 'lib', 'assets', 'himmelskoerper.rdf').to_s
  QUERYABLE = RDF::Repository.load(RDF_FILE)

  def index

  end

  def create
    begin
      sparql = SPARQL.parse(params[:query])
      solutions = QUERYABLE.query(sparql)
      @solutions = solutions
    rescue
      @message = "Fehler!"
    end
    render :index
  end

end
