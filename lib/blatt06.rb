class Blatt06
  RDF_FILE = (Rails.root.join 'lib', 'assets', 'himmelskoerper.rdf').to_s
  QUERYABLE = RDF::Repository.load(RDF_FILE)

  # Objekte, die um die Sonne oder um einen Satelliten der Sonne kreisen.
  # Merkur, Venus, Erde und Mars umkreisen die Sonne
  # Mond umkreist die Erde, Phobos und Deimos den Mars

  def self.aufgabe1a
    str = '
      PREFIX ex: <http://example.org/>
      SELECT ?object ?satellite WHERE
      {
       ?object ex:satellit ?satellite .
      }'
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
  end

  def self.aufgabe1b
    str = "
      PREFIX ex: <http://example.org/>
      SELECT DISTINCT ?object ?parent ?radius WHERE
      {
        { ?object ex:radius ?radius . }
        OPTIONAL { ?parent ex:satellit ?object . }
        FILTER (4/3 * #{Math::PI} * ?radius * ?radius * ?radius >= #{3*10**10})
      }
"
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
  end


  # Objekte mit einem Satelliten für den ein englischsprachiger Name gegeben ist, die außerdem Satellit eines Objektes von über 3000 (km) Durchmesser sind.
  def self.aufgabe1c
    str = "
      PREFIX ex: <http://example.org/>
      SELECT DISTINCT ?object ?name WHERE
      {
        {
          ?object ex:name ?name .
          ?parent ex:radius ?radius .
        }
        FILTER (
          ?radius >= 3000.0 &&
          lang(?name) = 'en'
        )
      }
"
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
  end

  # Objekte mit zwei oder mehr Satelliten
  def self.aufgabe1d
    str = "
      PREFIX ex: <http://example.org/>
      SELECT ?object (COUNT(?satellit) AS ?sat_count) WHERE
      {
        ?object ex:satellit ?satellit .
      }
      GROUP BY ?object
      HAVING(COUNT(?satellit) >= 2)
"
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
  end

  # Himmelskörper, die keinen Satelliten haben
  # <=> alles was Namen oder Radius hat = Himmelskörper (bzw. alle Subjects)
  def self.aufgabe4
    str = "
      PREFIX ex: <http://example.org/>
      SELECT DISTINCT ?object WHERE
      {
        { ?object ex:radius ?radius . }
        UNION
        { ?object ex:name ?name . }
        OPTIONAL { ?object ex:satellit ?satellit }
        FILTER (!bound(?satellit))
      }
"
    sparql = SPARQL.parse(str)
    solutions = QUERYABLE.query(sparql)
  end


end