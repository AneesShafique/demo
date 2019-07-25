ThinkingSphinx::Index.define :product, with: :active_record do
  # fields
  indexes title, sortable: true
  indexes price, sortable: true
end
