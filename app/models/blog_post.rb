class BlogPost < ApplicationRecord
    has_one_attached :cover_image
    has_rich_text :content
    validates :title ,  presence: true
    validates :content ,  presence: true


    scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
    scope :draft , -> { where(published: nil) }
    scope :published , -> { where("published_at <= ?", Time.now) }
    scope :scheduled , -> { where("published_at > ?", Time.now) }
    def draft?
        published_at.nil?
    end

    def published?
       published_at && published_at <= Time.now
    end
    def scheduled?
        published_at && published_at > Time.now
    end
end
