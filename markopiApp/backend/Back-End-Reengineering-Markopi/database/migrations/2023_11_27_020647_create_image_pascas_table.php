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
        Schema::create('image_pascas', function (Blueprint $table) {
            $table->increments('id_image_pascas');
            $table->string('gambar');
            $table->unsignedInteger('pasca_id');
            $table->timestamps();

            $table->foreign('pasca_id')->references('id_pascas')->on('pascas')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('image_pascas');
    }
};
