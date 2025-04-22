<!-- Brand Logo -->
<a href="index3.html" class="brand-link">
    <img src="{{ asset('template/dist/img/markopi.png') }}" alt="markopi" class="brand-image img-circle elevation-3"
        style="opacity: .8">
    <span class="brand-text font-weight-light">Markopi</span>
</a>

<!-- Sidebar -->
<div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
            <img src="{{ asset('template/dist/img/user2-160x160.jpg') }}" class="img-circle elevation-2"
                alt="User Image">
        </div>
        <div class="info">
            <a href="#" class="d-block">Admin Markopi</a>
        </div>
    </div>

    <!-- SidebarSearch Form -->
    <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
            <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
                <button class="btn btn-sidebar">
                    <i class="fas fa-search fa-fw"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
            <li class="nav-item">
                <a href="/admin/dashboard" class="nav-link {{ \Route::is('dashboard') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M10 20v-6h4v6h5v-8h3L12 3L2 12h3v8h5z" />
                        </svg>
                    </i>
                    <p>
                        Beranda
                    </p>
                </a>
            </li>

            <li i class="nav-item">
                <a href="/budidaya" class="nav-link {{ \Route::is('budidaya.index') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                stroke-width="2"
                                d="M7 15h10v4a2 2 0 0 1-2 2H9a2 2 0 0 1-2-2v-4zm5-6a6 6 0 0 0-6-6H3v2a6 6 0 0 0 6 6h3m0 0a6 6 0 0 1 6-6h3v1a6 6 0 0 1-6 6h-3m0 3V9" />
                        </svg>
                    </i>
                    <p>
                        Budidaya Kopi
                    </p>
                </a>
            </li>

            

            <li class="nav-item">
                <a href="/panen" class="nav-link {{ \Route::is('panen.index') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor"
                                d="M6 18a6.06 6.06 0 0 0 5.17-6a7.62 7.62 0 0 1 6.52-7.51l2.59-.37c-.07-.08-.13-.16-.21-.24c-3.26-3.26-9.52-2.28-14 2.18C2.28 9.9 1 15 2.76 18.46z" />
                            <path fill="currentColor"
                                d="M12.73 12a7.63 7.63 0 0 1-6.51 7.52l-2.46.35l.15.17c3.26 3.26 9.52 2.29 14-2.17C21.68 14.11 23 9 21.25 5.59l-3.34.48A6.05 6.05 0 0 0 12.73 12z" />
                        </svg>
                    </i>
                    <p>
                        Panen Kopi
                    </p>
                </a>
            </li>

            <li class="nav-item">
                <a href="/pasca" class="nav-link {{ \Route::is('pasca.index') ? 'active' : '' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 2048 2048">
                        <path fill="currentColor"
                            d="M448 1024q56 0 101 25t82 68t61 96t43 111t25 112t8 100q0 45-8 100t-25 112t-42 111t-62 96t-81 67t-102 26q-35 0-64-17q-29 17-64 17q-56 0-101-25t-82-68t-61-96t-43-111t-25-112t-8-100q0-45 8-100t25-112t42-111t62-96t81-67t102-26q35 0 64 17q29-17 64-17zm-321 512q0 45 7 91t21 90t36 86t51 76q16 19 34 30t44 11v-768q-25 0-43 11t-35 30q-29 35-51 76t-36 85t-21 91t-7 91zm321 384q25 0 43-11t35-30q29-34 50-75t36-86t22-91t7-91q0-45-7-91t-21-90t-36-86t-51-76q-16-19-34-30t-44-11v768zm1600-320q0 35-17 64q17 29 17 64q0 56-25 101t-68 82t-96 61t-111 43t-112 25t-100 8q-45 0-100-8t-112-25t-111-42t-96-62t-67-81t-26-102q0-35 17-64q-17-29-17-64q0-56 25-101t68-82t96-61t111-43t112-25t100-8q45 0 100 8t112 25t111 42t96 62t67 81t26 102zm-512-193q-45 0-91 7t-90 21t-86 36t-76 51q-19 16-30 34t-11 44h768q0-25-11-43t-30-35q-35-29-76-50t-85-36t-91-22t-91-7zm0 514q45 0 91-7t90-21t86-36t76-51q19-16 30-34t11-44h-768q0 25 11 43t30 35q34 29 75 51t86 36t91 21t91 7zm-384-914q-29 17-64 17q-56 0-101-25t-82-68t-61-96t-43-111t-25-112t-8-100q0-45 8-100t25-112t42-111t62-96t81-67t102-26q35 0 64 17q29-17 64-17q56 0 101 25t82 68t61 96t43 111t25 112t8 100q0 45-8 100t-25 112t-42 111t-62 96t-81 67t-102 26q-35 0-64-17zm257-495q0-45-7-91t-21-90t-36-86t-51-76q-16-19-34-30t-44-11v768q25 0 43-11t35-30q29-34 50-75t36-86t22-91t7-91zm-514 0q0 45 7 91t21 90t36 86t51 76q16 19 34 30t44 11V128q-25 0-43 11t-35 30q-29 35-51 76t-36 85t-21 91t-7 91z" />
                    </svg>
                    <p>
                        Pasca Panen Kopi
                    </p>
                </a>
            </li>
            <!-- menu sebelumnya -->
            <!--
             <li class="nav-item">
                <a href="/minuman" class="nav-link {{ \Route::is('minuman.index') ? 'active' : '' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 640 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
            <!--
                        <path fill="white"
                            d="M96 64c0-17.7 14.3-32 32-32H448h64c70.7 0 128 57.3 128 128s-57.3 128-128 128H480c0 53-43 96-96 96H192c-53 0-96-43-96-96V64zM480 224h32c35.3 0 64-28.7 64-64s-28.7-64-64-64H480V224zM32 416H544c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32z" />
                    </svg>
                    <p>
                        Minuman
                    </p>
                </a>
            </li>
            
             -->

            <!-- menu sebelumnya -->

            <li class="nav-item">
                <a href="{{ route('pengepul.index') }}" class="nav-link {{ \Route::is('pengepul.index') ? 'active' : '' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 640 512">
                        <path fill="white"
                            d="M96 64c0-17.7 14.3-32 32-32H448h64c70.7 0 128 57.3 128 128s-57.3 128-128 128H480c0 53-43 96-96 96H192c-53 0-96-43-96-96V64zM480 224h32c35.3 0 64-28.7 64-64s-28.7-64-64-64H480V224zM32 416H544c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32z" />
                    </svg>
                    <p>Data Pengepul</p>
                </a>
            </li>

            <li class="nav-item">
                <a href="{{ route('iklan.index') }}" class="nav-link {{ \Route::is('iklan.index') ? 'active' : '' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 640 512">
                        <path fill="white"
                            d="M96 64c0-17.7 14.3-32 32-32H448h64c70.7 0 128 57.3 128 128s-57.3 128-128 128H480c0 53-43 96-96 96H192c-53 0-96-43-96-96V64zM480 224h32c35.3 0 64-28.7 64-64s-28.7-64-64-64H480V224zM32 416H544c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32z" />
                    </svg>
                    <p>Iklan</p>
                </a>
            </li>



            <li i class="nav-item">
                <a href="/pengajuan" class="nav-link {{ \Route::is('pengajuan') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
                            <g fill="currentColor" fill-rule="evenodd" clip-rule="evenodd">
                                <path d="M4 8.25a1 1 0 1 0 0-2a1 1 0 0 0 0 2m0 2a3 3 0 1 0 0-6a3 3 0 0 0 0 6" />
                                <path
                                    d="M4.05 11a1.5 1.5 0 0 0-1.5 1.5V14a1 1 0 0 1-2 0v-1.5a3.5 3.5 0 0 1 7 0V14a1 1 0 1 1-2 0v-1.5a1.5 1.5 0 0 0-1.5-1.5M16 8.25a1 1 0 1 1 0-2a1 1 0 0 1 0 2m0 2a3 3 0 1 1 0-6a3 3 0 0 1 0 6" />
                                <path
                                    d="M15.95 11a1.5 1.5 0 0 1 1.5 1.5V14a1 1 0 1 0 2 0v-1.5a3.5 3.5 0 0 0-7 0V14a1 1 0 1 0 2 0v-1.5a1.5 1.5 0 0 1 1.5-1.5" />
                                <path
                                    d="M10.05 13.75a2.5 2.5 0 0 0-2.5 2.5v1.5a1 1 0 0 1-2 0v-1.5a4.5 4.5 0 0 1 9 0v1.5a1 1 0 1 1-2 0v-1.5a2.5 2.5 0 0 0-2.5-2.5" />
                                <path d="M10 11a1 1 0 1 0 0-2a1 1 0 0 0 0 2m0 2a3 3 0 1 0 0-6a3 3 0 0 0 0 6" />
                            </g>
                        </svg>
                    </i>
                    <p>
                        Pengajuan Fasilitator
                    </p>
                </a>
            </li>
            <li i class="nav-item">
                <a href="/data_user" class="nav-link {{ \Route::is('getDataUser') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
                            <g fill="currentColor" fill-rule="evenodd" clip-rule="evenodd">
                                <path d="M4 8.25a1 1 0 1 0 0-2a1 1 0 0 0 0 2m0 2a3 3 0 1 0 0-6a3 3 0 0 0 0 6" />
                                <path
                                    d="M4.05 11a1.5 1.5 0 0 0-1.5 1.5V14a1 1 0 0 1-2 0v-1.5a3.5 3.5 0 0 1 7 0V14a1 1 0 1 1-2 0v-1.5a1.5 1.5 0 0 0-1.5-1.5M16 8.25a1 1 0 1 1 0-2a1 1 0 0 1 0 2m0 2a3 3 0 1 1 0-6a3 3 0 0 1 0 6" />
                                <path
                                    d="M15.95 11a1.5 1.5 0 0 1 1.5 1.5V14a1 1 0 1 0 2 0v-1.5a3.5 3.5 0 0 0-7 0V14a1 1 0 1 0 2 0v-1.5a1.5 1.5 0 0 1 1.5-1.5" />
                                <path
                                    d="M10.05 13.75a2.5 2.5 0 0 0-2.5 2.5v1.5a1 1 0 0 1-2 0v-1.5a4.5 4.5 0 0 1 9 0v1.5a1 1 0 1 1-2 0v-1.5a2.5 2.5 0 0 0-2.5-2.5" />
                                <path d="M10 11a1 1 0 1 0 0-2a1 1 0 0 0 0 2m0 2a3 3 0 1 0 0-6a3 3 0 0 0 0 6" />
                            </g>
                        </svg>
                    </i>
                    <p>
                        Data User
                    </p>
                </a>
            </li>

            <li i class="nav-item">
            <a href="{{ route('artikel.admin') }}" class="nav-link {{ \Route::is('artikel.admin') ? 'active' : '' }}">
                    <i class="">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                stroke-width="2"
                                d="M7 15h10v4a2 2 0 0 1-2 2H9a2 2 0 0 1-2-2v-4zm5-6a6 6 0 0 0-6-6H3v2a6 6 0 0 0 6 6h3m0 0a6 6 0 0 1 6-6h3v1a6 6 0 0 1-6 6h-3m0 3V9" />
                        </svg>
                    </i>
                    <p>
                        Artikel
                    </p>
                </a>
            </li>

        </ul>
    </nav>


    <!-- /.sidebar-menu -->
</div>
<!-- /.sidebar -->