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
        Schema::create('image_panens', function (Blueprint $table) {
            $table->increments('id_image_panens');
            $table->string('gambar');
            $table->unsignedInteger('panen_id');
            $table->timestamps();
            
            $table->foreign('panen_id')->references('id_panens')->on('panens')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('image_panens');
    }
};
