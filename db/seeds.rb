# ---- PERSONAS ----
persona1 = Persona.create!(nombre: "Franco", apellido: "Guevara")
persona2 = Persona.create!(nombre: "Melina", apellido: "Gomez")
persona3 = Persona.create!(nombre: "Benjamin", apellido: "Sanchez")

puts "3 Personas creadas."

# ---- ARTÍCULOS ----
articulo1 = Articulo.create!(modelo: "T14", marca: "Lenovo", fecha_ingreso: "2025-08-01")
articulo2 = Articulo.create!(modelo: "MacBook Air", marca: "Apple", fecha_ingreso: "2025-08-02")
articulo3 = Articulo.create!(modelo: "ThinkPad X1", marca: "Lenovo", fecha_ingreso: "2025-08-03")
articulo4 = Articulo.create!(modelo: "Dell XPS", marca: "Dell", fecha_ingreso: "2025-08-04")
articulo5 = Articulo.create!(modelo: "HP 250G7", marca: "HP", fecha_ingreso: "2025-08-05")

puts "5 Artículos creados."

# ---- TRANSFERENCIAS ----
# Primera transferencia: Franco recibe articulo1
Transferencia.create!(
  articulo: articulo1,
  portador_anterior: nil,
  portador_nuevo: persona1,
  fecha_transferencia: "2025-08-06"
)

# Segunda transferencia: Melina recibe articulo2
Transferencia.create!(
  articulo: articulo2,
  portador_anterior: nil,
  portador_nuevo: persona2,
  fecha_transferencia: "2025-08-07"
)

puts "2 Transferencias iniciales creadas."

# Crear usuario admin
admin = User.find_or_create_by(email_address: 'admin@inventario.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'admin'
end

# Crear usuario normal
usuario = User.find_or_create_by(email_address: 'usuario@inventario.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'usuario'
end

puts "Usuarios creados:"
puts "Admin: admin@inventario.com / password123"
puts "Usuario: usuario@inventario.com / password123"

puts "Seeds completadas."
