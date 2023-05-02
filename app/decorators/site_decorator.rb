module SiteDecorator
  def favicon_url(sizes)
    return nil unless favicon.attached?

    favicon.variant(resize: sizes).processed
  end

  def og_image_url(version = :origin)
    return nil if !og_image.attached? || og_image.metadata.blank?

    command = case version
              when :ogp
                { resize: '1200x630' }
              else
                false
              end

    command ? og_image.variant(command).processed : og_image
  end
end
