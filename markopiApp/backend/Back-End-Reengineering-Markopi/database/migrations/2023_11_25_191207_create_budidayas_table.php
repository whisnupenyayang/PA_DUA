<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('budidayas', function (Blueprint $table) {
            $table->increments('id_budidayas');
            $table->string('tahapan');
            // $table->enum('jenis', ['-','arabika', 'robusta'])->default('-');
            $table->text('deskripsi');
            $table->string('link');
            // $table->string('sumber_artikel');
            $table->string('credit_gambar');
            $table->string('kategori');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('budidayas');
    }
};
