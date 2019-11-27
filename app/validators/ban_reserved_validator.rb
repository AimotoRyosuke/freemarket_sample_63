class BanReservedValidator < ActiveModel::EachValidator

  WORDS = %w{
    ちんこ まんこ
  }

  def validate_each(record, attribute, value)
    if (WORDS + WORDS.map {|w| w.pluralize}).include?(value)
      record.errors[attribute] << (options[:message] || "ニックネームに使えない文字列が含まれています")
    end
  end
end