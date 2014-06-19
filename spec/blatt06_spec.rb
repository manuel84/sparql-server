require 'rails_helper'
require 'blatt06'

describe 'Blatt06' do
  describe 'Aufgabe 1'
  it 'should return the correct satellites' do
    expected_satellites = %w(Merkur Venus Erde Mars Mond Phobos Deimos).map { |s| "http://example.org/#{s}"}
    expect(Blatt06.aufgabe1a.map { |sol| sol.satellite.to_s}).to eql(expected_satellites)
  end

  it 'should return objects with volume over 3 x 10^10 km^3' do
    expected_objects = %w(Sonne Merkur Venus Erde Mars).map { |s| "http://example.org/#{s}"}
    expect(Blatt06.aufgabe1b.map { |sol| sol.object.to_s}).to eql(expected_objects)
  end

  it 'should return objects with volume over 3 x 10^10 km^3 and their planet' do
    expected_objects = %w(Sonne).map { |s| "http://example.org/#{s}"}
    expect(Blatt06.aufgabe1b.map { |sol| sol.parent.to_s if sol.bound?(:parent)}.compact.uniq).to eql(expected_objects)
  end

  it 'should return english named satellites with parent object over 3000 km radius' do
    expected_objects = %w(Moon)
    expect(Blatt06.aufgabe1c.map { |sol| sol.name.to_s }).to eql(expected_objects)
  end

  it 'should return objects with more than one satellite' do
    expected_objects = %w(Sonne Mars).map { |s| "http://example.org/#{s}"}
    expect(Blatt06.aufgabe1d.map { |sol| sol.object.to_s }).to eql(expected_objects)
  end

  it 'should return objects with no satellite' do
    expected_objects = %w(Merkur Venus Mond Phobos Deimos).map { |s| "http://example.org/#{s}"}
    expect(Blatt06.aufgabe4.map { |sol| sol.object.to_s }).to eql(expected_objects)
  end
end