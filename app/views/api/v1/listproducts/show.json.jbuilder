# FindMyProduct API
# Copyright (C) 2020  00198216
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

#json.list @List, :id, :name, :quantity
#json.product @product, :id, :name
#json.quantity @association, :quantity

#json.info do
   # json.list @List.name
    #json.product_id @product.id
    #json.name @product.name
    #json.quantity @association.quantity
 # end
 @message= json.info @List do |list|
    json.id list.id
    json.name list.name
    json.products list.products do |product|
    json.product_id product.id
    json.product_name product.name
    @help= @association= ListProduct.find_by(
        list_id: list.id,
        product_id: product.id)
    json.product_quantity @help.quantity
    json.product_descripcion @help.description
    json.product_status @help.checked
    end
end