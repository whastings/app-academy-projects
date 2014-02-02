# Pair programming partner: Alexander Bryan

def deep_dup(to_dup)
  return to_dup unless to_dup.is_a?(Array)
  # unless to_dup.is_a?(Array)
#     to_dup = to_dup.dup if to_dup.respond_to?(:dup)
#     return to_dup
#   end
  to_dup.map do |dup_value|
    deep_dup(dup_value)
  end
end
