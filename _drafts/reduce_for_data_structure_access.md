From RubyTapas
Use reduce to access nested data structures, eg nested dicts

keys.reduce(data, :fetch)

updates data to next level of nested structure at each step using a list of keys
