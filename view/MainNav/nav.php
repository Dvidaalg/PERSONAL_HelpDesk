<?php
    if ($_SESSION["rol_id"]==1){
        ?>
            <nav class="side-menu">
                <ul class="side-menu-list">
                    <!-- <li class="blue-dirty">
                        <a href="..\Home\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Resumen</span>
                        </a>
                    </li> -->

                    <li class="blue-dirty">
                        <a href="..\NuevoTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Nuevo Ticket</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\ConsultarTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl"><!-- Consultar Ticket -->Listado De Ticket</span>
                        </a>
                    </li>
                </ul>
            </nav>
        <?php
    }else if($_SESSION["rol_id"]==2){
        ?>
            <nav class="side-menu">
                <ul class="side-menu-list">
                    <!-- <li class="blue-dirty">
                        <a href="..\Home\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Resumen</span>
                        </a>
                    </li> --> 

                    <li class="blue-dirty">
                        <a href="..\NuevoTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Nuevo Ticket</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\MntUsuario\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Mant. Usuario</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\MntPrioridad\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Mant. Prioridad</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\MntCategoria\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Mant. Categoria</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\MntSubCategoria\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Mant. Sub Categoria</span>
                        </a>
                    </li>

                    <li class="blue-dirty">
                        <a href="..\MntEstado\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Mant. Estado</span>
                        </a>
                    </li>
                    
                    <li class="blue-dirty">
                        <a href="..\ConsultarTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl"><!-- Consultar Ticket -->Listado De Ticket</span>
                        </a>
                    </li>
                </ul>
            </nav>
        <?php
    }else{
        ?>
            <nav class="side-menu">
                <ul class="side-menu-list">
                    <!-- <li class="blue-dirty">
                        <a href="..\Home\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Resumen</span>
                        </a>
                    </li> -->

                    <li class="blue-dirty">
                        <a href="..\NuevoTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl">Nuevo Ticket</span>
                        </a>
                    </li>
                    
                    <li class="blue-dirty">
                        <a href="..\ConsultarTicket\">
                            <span class="glyphicon glyphicon-th"></span>
                            <span class="lbl"><!-- Consultar Ticket -->Listado De Ticket</span>
                        </a>
                    </li>
                </ul>
            </nav>
        <?php
    }
?>
