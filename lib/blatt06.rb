class Blatt06
  RDF_FILE = (Rails.root.join 'lib', 'assets', 'himmelskoerper.rdf').to_s
  QUERYABLE = RDF::Repository.load(RDF_FILE)


  def self.aufgabe1
    str = '
      PREFIX ex: <http://example.org/>
      SELECT ?himmelskoerper WHERE
      {
        ex:Sonne ex:satellit ?himmelskoerper .
      }'
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
    solutions.each { |sol| puts sol.himmelskoerper }
  end

end