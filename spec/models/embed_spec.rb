# == Schema Information
#
# Table name: embeds
#
#  id         :bigint           not null, primary key
#  embed_type :integer          default("youtube"), not null
#  identifier :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Embed, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
