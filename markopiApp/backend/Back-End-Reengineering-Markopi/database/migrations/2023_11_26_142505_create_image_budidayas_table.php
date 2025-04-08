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
        Schema::create('image_budidayas', function (Blueprint $table) {
            $table->increments('id_image_budidayas');
            $table->string('gambar');
            $table->unsignedInteger('budidaya_id');
            $table->timestamps();

            $table->foreign('budidaya_id')->references('id_budidayas')->on('budidayas')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('image_budidayas');
    }
};
