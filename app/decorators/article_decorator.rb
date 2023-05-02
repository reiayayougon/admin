module ArticleDecorator
  def eye_catch_url(version = :origin)
    if !eye_catch.attached? || eye_catch.metadata.blank?
      return '/images/eye_catch.jpg'
    end

    command = case version
              when :thumb
                { resize: '640x480' }
              when :lg
                { resize: '1024x768' }
              when :ogp
                { resize: '120x630' }
              else
                false
              end

    command ? eye_catch.variant(command).processed : eye_catch
  end
end
