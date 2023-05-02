module AuthorDecorator
  def avatar_url(version = :origin)
    if !avatar.attached? || avatar.metadata.blank?
      return '/images/avatar.png'
    end

    command = case version
              when :icon
                metadata = avatar.metadata
                square(160, metadata[:width], metadata[:height])
              else
                false
              end

    command ? avatar.variant(command).processed : avatar
  end

  private

  def square(size, width, height)
    shave = if width < height
              remove = ((height - width) / 2).round
              "0x#{remove}"
            else
              remove = ((width - height) / 2).round
              "#{remove}x0"
            end

    {
      shave: shave,
      resize: "#{size}x#{size}"
    }
  end
end
