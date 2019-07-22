
                 <%  @abonos = product.get_abonos_detalle(@fecha1,@fecha2,product.customer_id,product.medio_id,product.secu_cont,product.moneda_id)%>    

                    <% if @abonos.all.size > 0 %>
                        <% @saldo = 0 %>

                        <% @abonos.each do |abonos| %> 
                              <%  @saldo += abonos.importe %>

                              <table style='font-family:"Courier New", Courier, monospace; font-size:80% ;width:100%'>
                              <tr>
                              <td width="15%"> </td>
                              <td width="8%">  <%= abonos.fecha.strftime("%d/%m/%Y")  %> </td>
                             
                              <td width="23%">  </td>
                             
                              <td width="10%" align="right"></td>
                              <td width="5%"  align="right"></td>
                              <td width="10%" align="right"><%= sprintf("%.2f",abonos.total.to_s)  %> </td>
                              
                              <td width="10%" align="right"> </td>
                              <td width="10%" align="right"> </td>
                              <td width="10%" align="right"><%= sprintf("%.2f",@saldo.to_s)%></td>
                              </tr>
                             </table>                 
                         <% end %>
               
                    <% end %>  