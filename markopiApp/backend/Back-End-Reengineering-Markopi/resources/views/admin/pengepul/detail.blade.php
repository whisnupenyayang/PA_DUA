@extends('admin.layouts.admin')

@section('no-navbar') 
    ->
@endsection
@section('no-header')
@endsection


@section('content')
<div class="row mb-3">
    <div class="col">
        <!-- Tombol Kembali -->
        <a href="{{ route('admin.pengepul') }}" class="btn btn-secondary">
            <i class="fa fa-arrow-left"></i> Kembali ke Daftar Pengepul
        </a>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h4>Detail Pengepul</h4>
            </div>
            <div class="card-body">
                <h5>{{ $pengepul->nama }}</h5>

                <!-- Alamat -->
                <p>
                    <strong>Alamat:</strong>
                    <span class="editable me-2" id="alamat" data-id="{{ $pengepul->id }}">{{ $pengepul->alamat }}</span>
                    <button class="btn btn-link btn-sm p-0 edit-icon" data-field="alamat" title="Edit">
                        <i class="fa fa-pencil-alt"></i>
                    </button>
                </p>

                <!-- Jenis Kopi -->
                <p>
                    <strong>Jenis Kopi:</strong>
                    <span class="editable me-2" id="jenis_kopi" data-id="{{ $pengepul->id }}">{{ $pengepul->jenis_kopi }}</span>
                    <button class="btn btn-link btn-sm p-0 edit-icon" data-field="jenis_kopi" title="Edit">
                        <i class="fa fa-pencil-alt"></i>
                    </button>
                </p>

                <!-- Jenis Produk -->
                <p>
                    <strong>Jenis Produk:</strong>
                    <span class="editable me-2" id="jenis_produk" data-id="{{ $pengepul->id }}">{{ $pengepul->jenis_produk }}</span>
                    <button class="btn btn-link btn-sm p-0 edit-icon" data-field="jenis_produk" title="Edit">
                        <i class="fa fa-pencil-alt"></i>
                    </button>
                </p>

                <!-- Harga -->
                <p>
                    <strong>Harga/kg:</strong>
                    <span class="editable me-2" id="harga" data-id="{{ $pengepul->id }}">Rp{{ number_format($pengepul->harga, 0, ',', '.') }}</span>
                    <button class="btn btn-link btn-sm p-0 edit-icon" data-field="harga" title="Edit">
                        <i class="fa fa-pencil-alt"></i>
                    </button>
                </p>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    $(document).ready(function () {
    $('.edit-icon').click(function () {
        var field = $(this).data('field');
        var $span = $('#' + field);
        var oldValue = $span.text().trim();
        var pengepulId = $span.data('id');

        if ($span.find('input, select').length > 0) return;

        var inputHtml = '';
        var options = [];

        if (field === 'harga') {
            oldValue = oldValue.replace(/[^\d]/g, '');
            inputHtml = `
                <div class="d-flex gap-2 align-items-center">
                    <input type="text" class="form-control form-control-sm" value="${oldValue}" id="input-${field}" style="max-width: 200px;">
                    <button class="btn btn-success btn-sm save-btn" data-field="${field}" data-id="${pengepulId}">Save</button>
                </div>
            `;
        } else if (field === 'jenis_kopi') {
            options = ['Arabika', 'Robusta'];
            inputHtml = `
                <div class="d-flex gap-2 align-items-center">
                    <select class="form-select form-select-sm" id="input-${field}" style="max-width: 200px;">
                        ${options.map(opt => `<option value="${opt}" ${opt === oldValue ? 'selected' : ''}>${opt}</option>`).join('')}
                    </select>
                    <button class="btn btn-success btn-sm save-btn" data-field="${field}" data-id="${pengepulId}">Save</button>
                </div>
            `;
        } else if (field === 'jenis_produk') {
            options = ['Kopi mentah', 'Kopi sangrai', 'Kopi bubuk'];
            inputHtml = `
                <div class="d-flex gap-2 align-items-center">
                    <select class="form-select form-select-sm" id="input-${field}" style="max-width: 200px;">
                        ${options.map(opt => `<option value="${opt}" ${opt === oldValue ? 'selected' : ''}>${opt}</option>`).join('')}
                    </select>
                    <button class="btn btn-success btn-sm save-btn" data-field="${field}" data-id="${pengepulId}">Save</button>
                </div>
            `;
        } else {
            inputHtml = `
                <div class="d-flex gap-2 align-items-center">
                    <input type="text" class="form-control form-control-sm" value="${oldValue}" id="input-${field}" style="max-width: 200px;">
                    <button class="btn btn-success btn-sm save-btn" data-field="${field}" data-id="${pengepulId}">Save</button>
                </div>
            `;
        }

        $span.html(inputHtml);
        $('#input-' + field).focus();
    });

    $(document).on('click', '.save-btn', function () {
        var field = $(this).data('field');
        var pengepulId = $(this).data('id');
        var $input = $('#input-' + field);
        var newValue = $input.val();
        var $span = $('#' + field);
        var oldValue = $input.closest('div').data('old-value') || '';

        $.ajax({
            url: "{{ route('admin.pengepul.updateField') }}",
            method: 'POST',
            data: {
                _token: "{{ csrf_token() }}",
                id: pengepulId,
                field: field,
                value: newValue
            },
            success: function (response) {
                if (response.success) {
                    if (field === 'harga') {
                        var formatted = new Intl.NumberFormat('id-ID').format(newValue);
                        $span.html('Rp' + formatted);
                    } else {
                        $span.text(newValue);
                    }
                } else {
                    alert('Gagal menyimpan perubahan.');
                    $span.text(oldValue);
                }
            },
            error: function () {
                alert('Terjadi kesalahan saat menyimpan data.');
                $span.text(oldValue);
            }
        });
    });
});

</script>
@endsection
