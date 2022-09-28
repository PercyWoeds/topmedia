# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220928184450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "currency",       limit: 10
    t.decimal  "exchange_rate",              precision: 14, scale: 4, default: 1.0
    t.decimal  "amount",                     precision: 14, scale: 2, default: 0.0
    t.string   "type",           limit: 30
    t.integer  "contact_id"
    t.integer  "project_id"
    t.boolean  "active",                                              default: true
    t.string   "description",    limit: 500
    t.date     "date"
    t.string   "state",          limit: 30
    t.boolean  "has_error",                                           default: false
    t.string   "error_messages", limit: 400
    t.integer  "tag_ids",                                             default: [],    array: true
    t.integer  "updater_id"
    t.decimal  "tax_percentage",             precision: 5,  scale: 2, default: 0.0
    t.integer  "tax_id"
    t.decimal  "total",                      precision: 14, scale: 2, default: 0.0
    t.boolean  "tax_in_out",                                          default: false
    t.integer  "creator_id"
    t.integer  "approver_id"
    t.integer  "nuller_id"
    t.date     "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["active"], name: "index_accounts_on_active", using: :btree
  add_index "accounts", ["amount"], name: "index_accounts_on_amount", using: :btree
  add_index "accounts", ["approver_id"], name: "index_accounts_on_approver_id", using: :btree
  add_index "accounts", ["contact_id"], name: "index_accounts_on_contact_id", using: :btree
  add_index "accounts", ["creator_id"], name: "index_accounts_on_creator_id", using: :btree
  add_index "accounts", ["currency"], name: "index_accounts_on_currency", using: :btree
  add_index "accounts", ["date"], name: "index_accounts_on_date", using: :btree
  add_index "accounts", ["description"], name: "index_accounts_on_description", using: :btree
  add_index "accounts", ["due_date"], name: "index_accounts_on_due_date", using: :btree
  add_index "accounts", ["has_error"], name: "index_accounts_on_has_error", using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", using: :btree
  add_index "accounts", ["nuller_id"], name: "index_accounts_on_nuller_id", using: :btree
  add_index "accounts", ["project_id"], name: "index_accounts_on_project_id", using: :btree
  add_index "accounts", ["state"], name: "index_accounts_on_state", using: :btree
  add_index "accounts", ["tag_ids"], name: "index_accounts_on_tag_ids", using: :btree
  add_index "accounts", ["tax_id"], name: "index_accounts_on_tax_id", using: :btree
  add_index "accounts", ["tax_in_out"], name: "index_accounts_on_tax_in_out", using: :btree
  add_index "accounts", ["type"], name: "index_accounts_on_type", using: :btree
  add_index "accounts", ["updater_id"], name: "index_accounts_on_updater_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "full_address"
    t.integer  "address2_id"
    t.integer  "customer_id"
  end

  create_table "almacens", force: :cascade do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "codigo"
    t.string   "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "avisodetails", force: :cascade do |t|
    t.string   "descrip"
    t.string   "comments"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "quantity"
    t.float    "price"
    t.float    "total"
    t.datetime "fecha"
    t.float    "tarifa"
    t.float    "i"
    t.string   "code"
    t.integer  "d01"
    t.integer  "d02"
    t.integer  "d03"
    t.integer  "d04"
    t.integer  "d05"
    t.integer  "d06"
    t.integer  "d07"
    t.integer  "d08"
    t.integer  "d09"
    t.integer  "d10"
    t.integer  "d11"
    t.integer  "d12"
    t.integer  "d13"
    t.integer  "d14"
    t.integer  "d15"
    t.integer  "d16"
    t.integer  "d17"
    t.integer  "d18"
    t.integer  "d19"
    t.integer  "d20"
    t.integer  "d21"
    t.integer  "d22"
    t.integer  "d23"
    t.integer  "d24"
    t.integer  "d25"
    t.integer  "d26"
    t.integer  "d27"
    t.integer  "d28"
    t.integer  "d29"
    t.integer  "d30"
    t.integer  "d31"
    t.integer  "category_program_id"
    t.integer  "medio_id"
  end

  create_table "bank_acounts", force: :cascade do |t|
    t.string   "number"
    t.integer  "moneda_id"
    t.integer  "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "cuenta"
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "phone1"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campania", force: :cascade do |t|
    t.string   "descrip"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "canals", force: :cascade do |t|
    t.string   "descrip"
    t.string   "ruc"
    t.string   "address1"
    t.string   "phone1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_programs", force: :cascade do |t|
    t.string   "code"
    t.string   "descrip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ciudads", force: :cascade do |t|
    t.string   "descrip"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "website"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo"
    t.string   "ruc"
  end

  create_table "company_users", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "concepts", force: :cascade do |t|
    t.string   "descrip"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conciliabank_details", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "tipomov_id"
    t.string   "integer"
    t.float    "cargo"
    t.float    "abono"
    t.string   "concepto"
    t.string   "nrocheque"
    t.string   "importado"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "conciliabank_id"
  end

  create_table "conciliabanks", force: :cascade do |t|
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.float    "saldo_inicial"
    t.float    "saldo_final"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "bank_acount_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "cargos"
    t.float    "abonos"
  end

  create_table "conciliations", force: :cascade do |t|
    t.integer  "bank_acount_id"
    t.integer  "document_id"
    t.string   "documento"
    t.integer  "supplier_id"
    t.float    "total"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.string   "descrip"
    t.string   "code"
    t.integer  "concept_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "contrato_abonos", force: :cascade do |t|
    t.datetime "fecha"
    t.integer  "customer_id"
    t.integer  "medio_id"
    t.string   "secu_cont"
    t.string   "observa"
    t.float    "importe"
    t.integer  "moneda_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "mesanio"
  end

  create_table "contrato_cuota", force: :cascade do |t|
    t.integer  "nro"
    t.datetime "fecha"
    t.float    "cuota"
    t.float    "vventa"
    t.float    "comision1"
    t.float    "comision2"
    t.float    "total"
    t.string   "facturacanal"
    t.string   "factura1"
    t.string   "factura2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contrato_details", force: :cascade do |t|
    t.string   "nro"
    t.datetime "fecha"
    t.float    "importe"
    t.float    "vventa"
    t.float    "comision1"
    t.float    "comision2"
    t.float    "total"
    t.string   "facturacanal"
    t.datetime "fecha2"
    t.string   "factura1"
    t.string   "factura2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "contrato_id"
    t.string   "sit"
    t.datetime "fechafac1"
    t.datetime "fechafac2"
    t.float    "comision3"
    t.datetime "fec_pago"
    t.float    "vv_f_emp1"
    t.float    "vv_f_emp2"
    t.text     "comments"
    t.float    "igv"
    t.datetime "fecha_pago"
    t.string   "estado"
  end

  create_table "contratos", force: :cascade do |t|
    t.string   "code"
    t.datetime "fecha"
    t.integer  "customer_id"
    t.integer  "medio_id"
    t.float    "importe"
    t.integer  "moneda_id"
    t.integer  "tipocontrato_id"
    t.float    "nrocuotas"
    t.float    "comision1"
    t.float    "comision2"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "contrato_cuota_id"
    t.string   "description"
    t.string   "codigointerno"
    t.float    "comision3"
    t.integer  "modalidad"
    t.integer  "anio"
  end

  create_table "csubdiarios", force: :cascade do |t|
    t.string   "csubdia"
    t.string   "ccompro"
    t.string   "ccodmon"
    t.string   "csitua"
    t.string   "ctipcam"
    t.string   "cglosa"
    t.float    "ctotal"
    t.string   "ctipo"
    t.string   "cflag"
    t.string   "cdate"
    t.string   "chora"
    t.string   "cfeccam"
    t.string   "cuser"
    t.string   "corig"
    t.string   "cform"
    t.string   "cextor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "cfeccom"
    t.string   "ccodane"
    t.float    "csubtotal"
    t.float    "ctax"
    t.float    "factory"
    t.float    "ajuste"
    t.float    "compen"
    t.float    "total1"
  end

  create_table "customer_contacts", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "cargo"
    t.string   "telefono1"
    t.string   "telefono2"
    t.string   "telefono3"
    t.string   "anexo1"
    t.string   "anexo2"
    t.string   "anexo3"
    t.string   "celular1"
    t.string   "celular2"
    t.string   "celular3"
    t.string   "correo1"
    t.string   "correo2"
    t.integer  "contacto_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
  end

  create_table "customer_contratos", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "secu_org"
    t.integer  "medio_id"
    t.integer  "contrato_id"
    t.string   "anio"
    t.string   "referencia"
    t.integer  "moneda_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "secu_cont"
  end

  create_table "customer_payment_details", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "documento"
    t.integer  "customer_id"
    t.string   "tm"
    t.float    "total"
    t.text     "descrip"
    t.integer  "factura_id"
    t.integer  "customer_payment_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "factory"
    t.float    "ajuste"
    t.float    "compen"
  end

  create_table "customer_payments", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "bank_account_id"
    t.integer  "document_id"
    t.string   "documento"
    t.integer  "customer_id"
    t.string   "tm"
    t.float    "total"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.string   "nrooperacion"
    t.string   "operacion"
    t.text     "descrip"
    t.text     "comments"
    t.integer  "user_id"
    t.string   "processed"
    t.datetime "date_processed"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "bank_acount_id"
    t.integer  "concept_id"
    t.float    "compen"
    t.integer  "moneda_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "email"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.text     "comments"
    t.string   "account"
    t.string   "taxable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "ruc"
    t.string   "active"
    t.integer  "{:index=>true, :foreign_key=>true}_id"
  end

  create_table "declaration_deliveries", force: :cascade do |t|
    t.integer  "delivery_id"
    t.integer  "declaration_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "declarations", force: :cascade do |t|
    t.string   "code"
    t.integer  "employee_id"
    t.integer  "punto_id"
    t.integer  "punto2_id"
    t.integer  "truck_id"
    t.integer  "truck2_id"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.text     "observacion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "customer_id"
    t.text     "description"
    t.text     "comments"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.string   "processes"
    t.string   "return"
    t.datetime "date_processes"
    t.integer  "user_id"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.integer  "employee_id"
    t.integer  "empsub_id"
    t.integer  "subcontrat_id"
    t.integer  "truck_id"
    t.integer  "truck2_id"
    t.integer  "address_id"
    t.integer  "remision"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "processed"
    t.integer  "division_id"
    t.float    "i"
    t.integer  "remite_id"
    t.integer  "address2_id"
    t.datetime "date_processed"
    t.integer  "tranportorder_id"
  end

  create_table "delivery_services", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "price"
    t.integer  "quantity"
    t.integer  "unidad_id"
    t.integer  "peso"
    t.float    "discount"
    t.float    "total"
    t.integer  "delivery_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "deliverymines", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "delivery_id"
    t.integer  "mine_id"
  end

  create_table "deliveryships", force: :cascade do |t|
    t.integer  "factura_id"
    t.integer  "delivery_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "company_id"
    t.string   "descripshort"
    t.string   "tiposunat"
    t.string   "tipo"
  end

  create_table "dsubdiarios", force: :cascade do |t|
    t.string   "dcompro"
    t.string   "dsecue"
    t.string   "dfeccom"
    t.string   "dcuenta"
    t.string   "dcodane"
    t.string   "dcencos"
    t.string   "dcodmon"
    t.string   "ddh"
    t.float    "dimport"
    t.string   "dtipdoc"
    t.string   "dnumdoc"
    t.string   "dfecdoc"
    t.string   "dfecven"
    t.string   "darea"
    t.string   "dflag"
    t.string   "dxglosa"
    t.string   "ddate"
    t.string   "dcodane2"
    t.string   "dusimpor"
    t.string   "dmnimpor"
    t.string   "dcodarc"
    t.string   "dtidref"
    t.string   "dndoref"
    t.string   "dfecref"
    t.string   "dbimref"
    t.string   "digvref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "dsubdiario"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "email1"
    t.string   "email2"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "licencia"
    t.string   "full_name"
  end

  create_table "factura_details", force: :cascade do |t|
    t.integer  "factura_id"
    t.integer  "contrato_cuota_id"
    t.float    "total"
    t.integer  "moneda_id"
    t.float    "tipocambio"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "contrato_detail_id"
    t.integer  "contrato_id"
    t.integer  "orden_id"
    t.integer  "medio_id"
    t.float    "price"
    t.float    "quantity"
    t.float    "discount"
    t.integer  "service_id"
  end

  create_table "facturas", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "customer_id"
    t.text     "description"
    t.text     "comments"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.string   "processed"
    t.string   "return"
    t.datetime "date_processed"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "fecha"
    t.string   "serie"
    t.string   "numero"
    t.string   "payment_id"
    t.string   "tipo"
    t.float    "pago"
    t.float    "charge"
    t.float    "balance"
    t.integer  "moneda_id"
    t.text     "observ"
    t.datetime "fecha2"
    t.string   "year_mounth"
    t.integer  "contrato_id"
    t.integer  "anio"
    t.integer  "medio_id"
    t.integer  "document_id"
    t.string   "tc"
    t.string   "nacional"
    t.integer  "orden_id"
    t.string   "msgerror"
    t.float    "cuota1"
    t.datetime "fecha_cuota1"
    t.float    "importe_cuota1"
    t.float    "cuota2"
    t.datetime "fecha_cuota2"
    t.float    "importe_cuota2"
    t.float    "cuota3"
    t.datetime "fecha_cuota3"
    t.float    "importe_cuota3"
    t.float    "cuota4"
    t.datetime "fecha_cuota4"
    t.float    "importe_cuota4"
    t.float    "cuota5"
    t.datetime "fecha_cuota5"
    t.float    "importe_cuota5"
    t.float    "detraccion_percent"
    t.float    "detraccion_importe"
    t.float    "retencion_importe"
    t.string   "detraccion_cuenta"
    t.float    "importe_neto"
    t.string   "servicio"
    t.float    "detraccion"
    t.float    "tipo_cambio"
    t.integer  "tipo_factura"
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "historiable_id"
    t.boolean  "new_item",         default: false
    t.string   "historiable_type"
    t.datetime "created_at",                       null: false
    t.string   "klass_type"
    t.datetime "updated_at",                       null: false
  end

  add_index "histories", ["created_at"], name: "index_histories_on_created_at", using: :btree
  add_index "histories", ["historiable_id"], name: "index_histories_on_historiable_id", using: :btree
  add_index "histories", ["user_id"], name: "index_histories_on_user_id", using: :btree

  create_table "instruccions", force: :cascade do |t|
    t.text     "description1"
    t.text     "description2"
    t.text     "description3"
    t.text     "description4"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "inventario_detalles", force: :cascade do |t|
    t.integer  "inventario_id"
    t.integer  "item_id"
    t.boolean  "activo"
    t.date     "fecha_vencimiento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.float    "cantidad"
    t.float    "precio_unitario"
  end

  create_table "inventarios", force: :cascade do |t|
    t.integer  "almacen_id"
    t.datetime "fecha"
    t.string   "descripcion"
    t.string   "tipo"
    t.decimal  "total",       precision: 12, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "store_id"
    t.integer  "account_id"
    t.date     "date"
    t.string   "ref_number"
    t.string   "operation",       limit: 10
    t.string   "state"
    t.string   "description"
    t.decimal  "total",                      precision: 14, scale: 2, default: 0.0
    t.integer  "creator_id"
    t.integer  "transference_id"
    t.integer  "store_to_id"
    t.integer  "project_id"
    t.boolean  "has_error",                                           default: false
    t.string   "error_messages"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventories", ["account_id"], name: "index_inventories_on_account_id", using: :btree
  add_index "inventories", ["contact_id"], name: "index_inventories_on_contact_id", using: :btree
  add_index "inventories", ["date"], name: "index_inventories_on_date", using: :btree
  add_index "inventories", ["has_error"], name: "index_inventories_on_has_error", using: :btree
  add_index "inventories", ["operation"], name: "index_inventories_on_operation", using: :btree
  add_index "inventories", ["project_id"], name: "index_inventories_on_project_id", using: :btree
  add_index "inventories", ["ref_number"], name: "index_inventories_on_ref_number", using: :btree
  add_index "inventories", ["state"], name: "index_inventories_on_state", using: :btree
  add_index "inventories", ["store_id"], name: "index_inventories_on_store_id", using: :btree

  create_table "inventory_details", force: :cascade do |t|
    t.integer  "inventory_operation_id"
    t.integer  "item_id"
    t.integer  "store_id"
    t.decimal  "quantity",               precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventory_details", ["inventory_operation_id"], name: "index_inventory_details_on_inventory_operation_id", using: :btree
  add_index "inventory_details", ["item_id"], name: "index_inventory_details_on_item_id", using: :btree
  add_index "inventory_details", ["store_id"], name: "index_inventory_details_on_store_id", using: :btree

  create_table "invoice_products", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.float    "price"
    t.integer  "quantity"
    t.float    "discount"
    t.float    "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_services", force: :cascade do |t|
    t.integer  "invoice2_id"
    t.integer  "service_id"
    t.float    "price"
    t.float    "quantity"
    t.float    "discount"
    t.float    "total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "preciocigv"
    t.integer  "factura_id"
  end

  create_table "invoiceitems", force: :cascade do |t|
    t.integer  "factura_id"
    t.string   "code"
    t.string   "cantidad"
    t.string   "um"
    t.string   "codigo"
    t.string   "descrip"
    t.float    "vunit"
    t.float    "punit"
    t.float    "vventa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "customer_id"
    t.text     "description"
    t.text     "comments"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.string   "processed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "return"
    t.datetime "date_processed"
    t.integer  "user_id"
  end

  create_table "invoicesunats", force: :cascade do |t|
    t.string   "cliente"
    t.date     "fecha"
    t.string   "td"
    t.string   "serie"
    t.string   "numero"
    t.float    "cantidad"
    t.float    "vventa"
    t.float    "igv"
    t.float    "importe"
    t.string   "ruc"
    t.string   "guia"
    t.string   "codplaca10"
    t.string   "formapago"
    t.text     "description"
    t.text     "comments"
    t.string   "descrip"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "preciocigv"
    t.float    "preciosigv"
    t.integer  "moneda"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "unit_id"
    t.decimal  "price",                   precision: 14, scale: 2, default: 0.0
    t.string   "name"
    t.string   "description"
    t.string   "code",        limit: 100
    t.boolean  "for_sale",                                         default: true
    t.boolean  "stockable",                                        default: true
    t.boolean  "active",                                           default: true
    t.decimal  "buy_price",               precision: 14, scale: 2, default: 0.0
    t.string   "unit_symbol", limit: 20
    t.string   "unit_name"
    t.integer  "tag_ids",                                          default: [],   array: true
    t.integer  "updater_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "qty"
    t.integer  "recibir"
  end

  add_index "items", ["code"], name: "index_items_on_code", using: :btree
  add_index "items", ["creator_id"], name: "index_items_on_creator_id", using: :btree
  add_index "items", ["for_sale"], name: "index_items_on_for_sale", using: :btree
  add_index "items", ["stockable"], name: "index_items_on_stockable", using: :btree
  add_index "items", ["tag_ids"], name: "index_items_on_tag_ids", using: :btree
  add_index "items", ["unit_id"], name: "index_items_on_unit_id", using: :btree
  add_index "items", ["updater_id"], name: "index_items_on_updater_id", using: :btree

  create_table "kits_products", force: :cascade do |t|
    t.integer  "product_kit_id"
    t.integer  "product_id"
    t.string   "session"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "quantity",         default: 1
    t.integer  "order_id"
    t.integer  "purchaseorder_id"
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "website"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manifests", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "solicitante"
    t.datetime "fecha1"
    t.string   "telefono1"
    t.integer  "camionetaqty"
    t.integer  "camionetapeso"
    t.integer  "camionqty"
    t.integer  "camionpeso"
    t.integer  "semiqty"
    t.integer  "semipeso"
    t.integer  "extenqty"
    t.integer  "extenpeso"
    t.integer  "camaqty"
    t.integer  "camapeso"
    t.integer  "modularqty"
    t.integer  "modularpeso"
    t.integer  "punto_id"
    t.integer  "punto2_id"
    t.datetime "fecha2"
    t.string   "contacto1"
    t.string   "contacto2"
    t.string   "telefono2"
    t.text     "especificacion"
    t.float    "largo"
    t.float    "ancho"
    t.float    "alto"
    t.integer  "peso"
    t.integer  "bultos"
    t.string   "otros"
    t.text     "observa"
    t.text     "observa2"
    t.integer  "company_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "marcas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
  end

  create_table "medio_contacts", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "cargo"
    t.string   "telefono1"
    t.string   "telefono2"
    t.string   "telefono3"
    t.string   "anexo1"
    t.string   "anexo2"
    t.string   "anexo3"
    t.string   "celular1"
    t.string   "celular2"
    t.string   "celular3"
    t.string   "correo1"
    t.string   "correo2"
    t.integer  "medio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "medio_contacts", ["medio_id"], name: "index_medio_contacts_on_medio_id", using: :btree

  create_table "medio_customers", force: :cascade do |t|
    t.integer  "medio_id"
    t.integer  "customer_id"
    t.float    "comision1"
    t.float    "comision2"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "orden_comision_id"
  end

  create_table "medio_details", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "medio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "medio_details", ["medio_id"], name: "index_medio_details_on_medio_id", using: :btree

  create_table "medios", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sigla"
    t.text     "address"
    t.string   "phone1"
    t.string   "atencion"
    t.string   "ruc"
    t.string   "active"
    t.string   "grupo"
    t.string   "estacion"
    t.string   "full_name"
    t.string   "taxable"
    t.string   "code"
    t.string   "address1"
  end

  create_table "modelos", force: :cascade do |t|
    t.string   "descrip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  create_table "monedas", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.string   "symbol"
    t.integer  "company_id"
  end

  create_table "motivos", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movement_details", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "item_id"
    t.float    "quantity",                                default: 0.0
    t.decimal  "price",          precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.decimal  "discount",       precision: 14, scale: 2, default: 0.0
    t.decimal  "balance",        precision: 14, scale: 2, default: 0.0
    t.decimal  "original_price", precision: 14, scale: 2, default: 0.0
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "product_id"
    t.float    "stock_inicial"
    t.float    "ingreso"
    t.float    "salida"
    t.float    "stock_final"
    t.datetime "fecha"
    t.integer  "user_id"
    t.integer  "document_id"
    t.string   "documento"
    t.string   "tm"
  end

  add_index "movement_details", ["account_id"], name: "index_movement_details_on_account_id", using: :btree
  add_index "movement_details", ["item_id"], name: "index_movement_details_on_item_id", using: :btree

  create_table "movement_products", force: :cascade do |t|
    t.integer  "movement_id"
    t.integer  "product_id"
    t.integer  "unidad_id"
    t.float    "price"
    t.integer  "quantity"
    t.float    "discount"
    t.float    "total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "movements", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "supplier_id"
    t.text     "description"
    t.text     "comments"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.integer  "payment_id"
    t.string   "money"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "detraccion"
    t.float    "percepcion"
    t.float    "total"
    t.string   "processed"
    t.string   "return"
    t.datetime "date_proceseed"
    t.integer  "user_id"
    t.string   "tm"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "document_id"
    t.string   "documento"
    t.string   "purchaseorder"
  end

  create_table "numeras", force: :cascade do |t|
    t.string   "subdiario"
    t.string   "compro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orden_comisions", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orden_product_imports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orden_products", force: :cascade do |t|
    t.integer  "orden_id"
    t.integer  "avisodetail_id"
    t.float    "price"
    t.float    "quantity"
    t.float    "total"
    t.datetime "fecha"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "tarifa"
    t.float    "i"
    t.string   "dia"
    t.integer  "d01"
    t.integer  "d02"
    t.integer  "d03"
    t.integer  "d04"
    t.integer  "d05"
    t.integer  "d06"
    t.integer  "d07"
    t.integer  "d08"
    t.integer  "d09"
    t.integer  "d10"
    t.integer  "d11"
    t.integer  "d12"
    t.integer  "d13"
    t.integer  "d14"
    t.integer  "d15"
    t.integer  "d16"
    t.integer  "d17"
    t.integer  "d18"
    t.integer  "d19"
    t.integer  "d20"
    t.integer  "d21"
    t.integer  "d22"
    t.integer  "d23"
    t.integer  "d24"
    t.integer  "d25"
    t.integer  "d26"
    t.integer  "d27"
    t.integer  "d28"
    t.integer  "d29"
    t.integer  "d30"
    t.integer  "d31"
    t.string   "canal"
    t.string   "descrip"
    t.string   "d"
    t.string   "h"
    t.string   "cantidad"
    t.string   "rating"
    t.string   "rating2"
    t.string   "tpp"
    t.string   "impactos"
    t.string   "miles"
    t.string   "impactos2"
    t.string   "cpp"
    t.string   "cpm"
    t.string   "cmp2"
    t.string   "cpm2"
    t.float    "duracion"
    t.string   "medidax"
    t.string   "ubicacion"
    t.string   "ciudad"
    t.string   "periodo"
    t.string   "detalle"
    t.float    "tarifa_cpm"
    t.float    "impresion_click"
    t.string   "website"
    t.float    "nro_salas"
    t.float    "nro_semanas"
    t.string   "movie"
    t.string   "cobertura"
    t.string   "horario"
    t.integer  "tipo_aviso_id"
    t.integer  "tipo_tarifa_id"
    t.integer  "tipo_tarifas_id"
    t.integer  "medio_detail_id"
    t.string   "pelicula"
    t.integer  "tipo_cpm_id"
    t.integer  "tipo_formato_id"
  end

  add_index "orden_products", ["tipo_tarifas_id"], name: "index_orden_products_on_tipo_tarifas_id", using: :btree

  create_table "ordens", force: :cascade do |t|
    t.integer  "contrato_id"
    t.datetime "fecha"
    t.integer  "medio_id"
    t.integer  "marca_id"
    t.integer  "version_id"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.float    "tiempo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "code"
    t.integer  "company_id"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.integer  "user_id"
    t.string   "processed"
    t.integer  "customer_id"
    t.text     "description"
    t.string   "rating"
    t.integer  "month"
    t.integer  "year"
    t.integer  "revision"
    t.integer  "producto_id"
    t.integer  "ciudad_id"
    t.datetime "date_processed"
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.float    "tarifa"
    t.integer  "aviso_detail_id"
    t.integer  "avisodetail_id"
    t.string   "tipo"
    t.string   "secu_cont"
    t.integer  "moneda_id"
    t.float    "quantity"
    t.float    "cantidad"
    t.float    "importe"
    t.string   "status"
    t.string   "mesanio"
    t.string   "program"
    t.integer  "tipo_orden_id"
    t.string   "facturado"
    t.string   "factura_id"
    t.string   "integer"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.integer  "user_id"
    t.string   "ruc"
  end

  create_table "output_details", force: :cascade do |t|
    t.integer  "output_id"
    t.integer  "product_id"
    t.float    "price"
    t.float    "quantity"
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outputs", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.text     "description"
    t.text     "comments"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.string   "processed"
    t.string   "return"
    t.datetime "date_processed"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "supplier_id"
    t.integer  "employee_id"
    t.integer  "truck_id"
    t.datetime "fecha"
  end

  create_table "packages", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.float    "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companies"
    t.integer  "locations"
    t.integer  "users"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "title_clean"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name"
    t.string   "internal_type"
    t.integer  "vendor_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "hidden",        default: 0
    t.integer  "hidden_by"
    t.boolean  "cash"
    t.boolean  "change"
    t.boolean  "unpaid"
    t.boolean  "quote"
    t.integer  "position"
    t.integer  "company_id"
    t.datetime "hidden_at"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comment"
    t.integer  "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  create_table "periodos", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "name"
    t.integer  "marca_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "category"
    t.integer  "supplier_id"
    t.float    "cost"
    t.float    "price"
    t.string   "tax1_name"
    t.float    "tax1"
    t.string   "tax2_name"
    t.float    "tax2"
    t.string   "tax3_name"
    t.float    "tax3"
    t.integer  "reorder"
    t.text     "description"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.float    "discount"
    t.float    "CurrTotal"
    t.integer  "i"
    t.float    "price2"
    t.string   "status"
    t.integer  "quantity_transit"
    t.integer  "marca_id"
    t.integer  "modelo_id"
    t.integer  "products_category_id"
    t.integer  "category_id"
    t.integer  "ubica_id"
    t.string   "unidad"
    t.string   "ubicacion"
    t.float    "quantity"
  end

  create_table "products_categories", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "products_kits", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "pumps", force: :cascade do |t|
    t.string   "fuel"
    t.string   "pump01"
    t.integer  "tank_id"
    t.integer  "product_id"
    t.float    "price_buy"
    t.float    "price_sell"
    t.float    "le_an_gln"
    t.float    "le_ac_gln"
    t.float    "gln"
    t.datetime "date1"
    t.integer  "employee_id"
    t.string   "turno"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "puntos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "unit_id"
    t.float    "price_with_tax"
    t.float    "price_without_tax"
    t.float    "price_public"
    t.float    "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.float    "totaltax"
    t.float    "totaltax2"
    t.float    "discount"
    t.float    "total"
    t.integer  "purchase_id"
    t.float    "inafect"
    t.float    "impuesto"
  end

  create_table "purchaseorder_details", force: :cascade do |t|
    t.integer  "purchaseorder_id"
    t.integer  "product_id"
    t.integer  "unidad_id"
    t.float    "price"
    t.float    "quantity"
    t.float    "discount"
    t.float    "total"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "quantity_transit"
    t.integer  "pending"
  end

  create_table "purchaseorders", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "supplier_id"
    t.text     "description"
    t.text     "comments"
    t.datetime "fecha1"
    t.integer  "payment_id"
    t.string   "money"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "detraccion"
    t.float    "percepcion"
    t.float    "total"
    t.string   "processed"
    t.string   "return"
    t.datetime "date_proceseed"
    t.integer  "user_id"
    t.string   "moneda"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "received"
    t.datetime "date_processed"
    t.integer  "moneda_id"
    t.datetime "fecha2"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "document_type_id"
    t.datetime "date1"
    t.datetime "date2"
    t.float    "exchange"
    t.integer  "unit_id"
    t.float    "price_with_tax"
    t.float    "price_without_tax"
    t.float    "price_public"
    t.float    "quantity"
    t.integer  "other"
    t.float    "discount"
    t.float    "tax1"
    t.float    "payable_amount"
    t.float    "tax_amount"
    t.float    "total_amount"
    t.string   "status"
    t.string   "pricestatus"
    t.float    "charge"
    t.float    "balance"
    t.float    "tax2"
    t.integer  "supplier_id"
    t.string   "order1"
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.text     "comments"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "processed"
    t.string   "return"
    t.datetime "date_processed"
    t.string   "money"
    t.integer  "payment_id"
    t.integer  "document_id"
    t.integer  "moneda_id"
    t.string   "documento"
    t.datetime "date3"
    t.float    "pago"
    t.integer  "purchaseorder_id"
    t.string   "yearmonth"
    t.float    "inafect"
    t.float    "inafecto"
    t.datetime "fecha3"
  end

  create_table "purchaseships", force: :cascade do |t|
    t.integer  "serviceorder_id"
    t.integer  "purchase_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "quota", force: :cascade do |t|
    t.string   "nro"
    t.datetime "fecha"
    t.float    "importe"
    t.float    "vventa"
    t.float    "comision1"
    t.float    "comision2"
    t.float    "total"
    t.string   "facturacanal"
    t.datetime "fecha2"
    t.string   "factura1"
    t.string   "factura2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "quotations", force: :cascade do |t|
    t.datetime "fecha1"
    t.string   "code"
    t.integer  "customer_id"
    t.integer  "punto_id"
    t.text     "carga"
    t.text     "tipo_unidad"
    t.float    "importe"
    t.text     "condiciones"
    t.text     "respon"
    t.text     "seguro"
    t.integer  "firma_id"
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.integer  "nro"
    t.datetime "fecha"
    t.float    "importe"
    t.float    "vventa"
    t.float    "comision1"
    t.float    "comision2"
    t.float    "total"
    t.string   "facturacanal"
    t.string   "factura1"
    t.string   "factura2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "contrato_id"
  end

  create_table "restocks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "supplier_id"
    t.integer  "quantity"
    t.datetime "when"
    t.string   "received"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "code"
    t.string   "already_processed"
  end

  create_table "servicebuys", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.float    "cost"
    t.float    "price"
    t.string   "tax1_name"
    t.float    "tax1"
    t.string   "tax2_name"
    t.float    "tax2"
    t.string   "tax3_name"
    t.float    "tax3"
    t.integer  "quantity"
    t.text     "description"
    t.text     "comments"
    t.integer  "company_id"
    t.float    "discount"
    t.float    "currtotal"
    t.integer  "i"
    t.float    "total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "serviceorder_services", force: :cascade do |t|
    t.integer  "serviceorder_id"
    t.integer  "service_id"
    t.float    "price"
    t.integer  "quantity"
    t.float    "discount"
    t.float    "total"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "servicebuy_id"
  end

  create_table "serviceorders", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "supplier_id"
    t.text     "description"
    t.text     "comments"
    t.datetime "fecha1"
    t.integer  "payment_id"
    t.string   "money"
    t.string   "code"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "detraccion"
    t.float    "percepcion"
    t.float    "total"
    t.string   "processed"
    t.string   "return"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "instruccion_id"
    t.string   "moneda"
    t.integer  "moneda_id"
    t.datetime "date_processed"
    t.integer  "document_id"
    t.datetime "fecha2"
    t.datetime "fecha3"
    t.datetime "fecha4"
    t.string   "documento"
    t.integer  "purchase_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.float    "cost"
    t.float    "price"
    t.string   "tax1_name"
    t.float    "tax1"
    t.float    "quantity"
    t.text     "description"
    t.text     "comments"
    t.integer  "company_id"
    t.float    "discount"
    t.float    "currtotal"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "i"
    t.float    "total"
    t.integer  "peso"
    t.integer  "unidad_id"
    t.string   "cuenta"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.integer  "user_id"
    t.string   "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "stamentacount_details", force: :cascade do |t|
    t.datetime "fecha"
    t.integer  "tipomov_id"
    t.float    "cargo"
    t.float    "abono"
    t.string   "concepto"
    t.string   "nrocheque"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "stamentacount_id"
    t.string   "importado"
  end

  create_table "stamentacounts", force: :cascade do |t|
    t.integer  "bank_account_id"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.float    "saldo_inicial"
    t.float    "saldo_final"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "stamentacount_id"
    t.integer  "bank_acount_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "item_id"
    t.string   "state",        limit: 20
    t.integer  "user_id"
    t.boolean  "active",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.float    "unitary_cost"
    t.float    "quantity"
    t.float    "minimum"
    t.integer  "document_id"
    t.string   "documento"
  end

  add_index "stocks", ["item_id"], name: "index_stocks_on_item_id", using: :btree
  add_index "stocks", ["state"], name: "index_stocks_on_state", using: :btree
  add_index "stocks", ["store_id"], name: "index_stocks_on_store_id", using: :btree
  add_index "stocks", ["user_id"], name: "index_stocks_on_user_id", using: :btree

  create_table "subcontrats", force: :cascade do |t|
    t.string   "ruc"
    t.string   "name"
    t.string   "address1"
    t.string   "distrito"
    t.string   "provincia"
    t.string   "dpto"
    t.string   "pais"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_payments", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.integer  "bank_acount_id"
    t.integer  "document_id"
    t.string   "documento"
    t.integer  "supplier_id"
    t.string   "tm"
    t.float    "total"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.string   "nrooperacion"
    t.string   "operacion"
    t.text     "descrip"
    t.text     "comments"
    t.integer  "user_id"
    t.string   "processed"
    t.datetime "date_processed"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "code"
    t.integer  "concept_id"
  end

  create_table "supplierpayment_details", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "documento"
    t.integer  "supplier_id"
    t.string   "tm"
    t.float    "total"
    t.text     "descrip"
    t.integer  "purchase_id"
    t.integer  "supplier_payment_id"
    t.float    "tipocambio"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "numero_documento"
    t.datetime "fecha_documento"
    t.float    "nrooperacion"
    t.float    "operacion"
    t.integer  "concept_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "ruc",        limit: 11
    t.string   "taxable"
    t.string   "account"
    t.string   "tipo"
  end

  create_table "tanks", force: :cascade do |t|
    t.string   "comments"
    t.integer  "product_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tanks", ["company_id"], name: "index_tanks_on_company_id", using: :btree
  add_index "tanks", ["product_id"], name: "index_tanks_on_product_id", using: :btree

  create_table "tipo_avisos", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_cpms", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_formatos", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_ordens", force: :cascade do |t|
    t.string   "code"
    t.string   "descrip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_tarifas", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipoavisos", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "duracion"
  end

  create_table "tipocambios", force: :cascade do |t|
    t.datetime "dia"
    t.float    "compra"
    t.float    "venta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipofacturas", force: :cascade do |t|
    t.string   "descrip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  create_table "tipomovs", force: :cascade do |t|
    t.string   "code"
    t.string   "descrip"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tranportorders", force: :cascade do |t|
    t.string   "code"
    t.integer  "employee_id"
    t.integer  "truck_id"
    t.integer  "employee2_id"
    t.integer  "truck2_id"
    t.integer  "ubication_id"
    t.integer  "ubication2_id"
    t.datetime "fecha1"
    t.datetime "fecha2"
    t.text     "description"
    t.text     "comments"
    t.string   "processed"
    t.integer  "company_id"
    t.integer  "location_id"
    t.integer  "division_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "transferencia_detalles", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "transferencia_id"
    t.float    "cantidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transferencias", force: :cascade do |t|
    t.integer  "almacen_origen_id"
    t.integer  "almacen_destino_id"
    t.datetime "fecha"
    t.float    "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trucks", force: :cascade do |t|
    t.string   "code"
    t.string   "placa"
    t.string   "clase"
    t.integer  "marca_id"
    t.integer  "modelo_id"
    t.string   "certificado"
    t.integer  "ejes"
    t.string   "licencia"
    t.string   "neumatico"
    t.string   "config"
    t.string   "carroceria"
    t.integer  "anio"
    t.string   "estado"
    t.string   "propio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ubicas", force: :cascade do |t|
    t.string   "descrip"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ubications", force: :cascade do |t|
    t.string   "descrip"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unidads", force: :cascade do |t|
    t.string   "descrip"
    t.float    "valorconversion"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_packages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "companies"
    t.integer  "locations"
    t.integer  "users"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "descrip"
    t.integer  "producto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "motivo"
  end

  create_table "voideds", force: :cascade do |t|
    t.string   "serie"
    t.string   "numero"
    t.string   "texto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "medio_contacts", "medios"
  add_foreign_key "medio_details", "medios"
  add_foreign_key "orden_products", "tipo_tarifas"
  add_foreign_key "tanks", "companies"
  add_foreign_key "tanks", "products"
end
