class Todo < ActiveRecord::Base

  def status!
    update!(done: !done)
  end
end
