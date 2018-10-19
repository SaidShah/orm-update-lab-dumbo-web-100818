require_relative "../config/environment.rb"
require "pry"
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
attr_accessor :id, :name, :grade

  def initialize(id= nil, name , grade )
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql,self.name,self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name, grade)
    new_student = Student.new(name,grade)
    new_student.save
    new_student
  end

  def self.new_from_db(given_value)
    Student.new(given_value[0],given_value[1],given_value[2])
  end







end
