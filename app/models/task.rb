class Task < ApplicationRecord
  validate :validate_name_not_including_comma_or_dot
  validates :name, presence: true, length: { maximum: 30 }

  private

  def validate_name_not_including_comma_or_dot
    errors.add(:name, 'にカンマ、ドットを含めることはできません') if name&.include?(',') || name&.include?('.')
  end
end
