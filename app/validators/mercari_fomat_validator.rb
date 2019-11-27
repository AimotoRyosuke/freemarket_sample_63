class MercariFomatValidator < ActiveModel::EachValidator

  WORDS = %w{
    メルカリ
  }

  def validate_each(record, attribute, value)
    if (WORDS + WORDS.map {|w| w.pluralize}).include?(value)
      record.errors[attribute] << (options[:message] || "メルカリという文字列は、ニックネームには使えません")
    end
  end

end