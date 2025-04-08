<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ArtikelResourc extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id_artikels' => $this->id_artikels,
            'judul_artikel' => $this->judul_artikel,
            'isi_artikel' =>  $this->isi_artikel,
            'create_at' => $this->created_at,
            'images'=>'nando.jpg',
            'user_id'=> $this->user_id,
            'statusCode'=>200,
        ];
    }
}
