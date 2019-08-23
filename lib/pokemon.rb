class Pokemon

  attr_accessor :name, :type, :db, :id

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL
      db.execute(sql, self.name, self.type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
  end

  def update
    sql = "UPDATE pokemon SET name = ?, type = ?, WHERE id = ?"
    db.execute(sql, self.name, self.type, self.id)
  end

  def find(name)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE name = ?
      LIMIT 1
    SQL
    #db.execute(sql,name).map do |row|
  end

end
