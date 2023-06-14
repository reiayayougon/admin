namespace :fix_embed_youtube_identifier do
    desc 'IDを入力していた場合indentiferカラムの過去のデータを一括で修正'
    task uodate_old_indentifier_for_youtube_embed: :environment do
        Embed.youtube.each do |embed|
            embed.update(identifier: "https://youtu.be/#{embed.identifier}")
        end
    end
end
