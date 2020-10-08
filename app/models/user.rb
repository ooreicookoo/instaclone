class User < ApplicationRecord
  def change
    mount_uploader :image, ImageUploader
      t.string :name, presenec: true
      t.string :email, presenec: true
      t.string :password_digest
      t.timestamps
    end
  end
