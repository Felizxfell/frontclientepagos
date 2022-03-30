<template>
  <div class="my-10">
    <form @submit.prevent="submit">
      <div class="shadow overflow-hidden sm:rounded-md">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3">
              <label
                for="cliente"
                class="block text-sm font-medium text-gray-700"
                >Cliente</label
              >
              <select
                id="cliente"
                v-model="clienteSelect"
                class="
                  mt-1
                  block
                  w-full
                  py-2
                  px-3
                  border border-gray-300
                  bg-white
                  rounded-md
                  shadow-sm
                  focus:outline-none focus:ring-gray-500 focus:border-gray-500
                  sm:text-sm
                "
              >
                <option value="0" selected>--cliente--</option>
                <option
                  v-for="cliente in clientesOp"
                  :key="cliente.id"
                  :value="cliente.id"
                >
                  {{ cliente.nombre }}
                </option>
              </select>
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label for="monto" class="block text-sm text-gray-700"
                >Monto</label
              >
              <input
                type="text"
                v-model.trim="monto"
                id="monto"
                autocomplete="off"
                class="
                  mt-1
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-700
                  rounded-md
                "
              />
            </div>
          </div>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <button
            type="submit"
            class="
              inline-flex
              justify-center
              py-2
              px-4
              border border-transparent
              shadow-sm
              text-sm
              rounded-md
              text-white
              bg-blue-600
              hover:bg-blue-700
              focus:outline-none
            "
          >
            Save
          </button>
        </div>
      </div>
    </form>
  </div>
  <div class="relative overflow-x-auto sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead
        class="
          text-xs text-gray-700
          uppercase
          bg-gray-50
          dark:bg-gray-700 dark:text-gray-400
        "
      >
        <tr>
          <th scope="col" class="px-6 py-3">Cliente</th>
          <th scope="col" class="px-6 py-3">ID PAGO</th>
          <th scope="col" class="px-6 py-3">Monto</th>
          <th scope="col" class="px-6 py-3">
            <span class="sr-only"></span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr class="bg-white border-b" v-for="pago in pagos" :key="pago.id">
          <th scope="row" class="px-6 py-4 whitespace-nowrap">
            {{ pago.clienteId }} - {{ pago.nombreCliente }}
          </th>
          <td class="px-6 py-4">{{ pago.id }}</td>
          <td class="px-6 py-4 text-right">
            ${{ decimalsWithCommas(pago.monto) }}
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
// import { decimalsWithCommas } from "@/utils/index";

export default {
  name: "FormPago",
  setup() {
    onMounted(() => {
      cargaClientes();
      cargaPagos();
    });

    const clientesOp = ref([]);
    const clienteSelect = ref(0);
    const monto = ref(0);
    const pagos = ref([]);
    const URLAPICLIENTE = "https://localhost:7066/api/Clientes/";
    const URLAPIPAGO = "https://localhost:7066/api/Pagos/";

    const cargaClientes = async () => {
      try {
        const reqs = await fetch(URLAPICLIENTE);
        const resp = await reqs.json();
        clientesOp.value = resp;
      } catch (error) {
        throw new Error(error);
      }
    };

    const cargaPagos = async () => {
      try {
        const reqs = await fetch(URLAPIPAGO);
        const resp = await reqs.json();
        pagos.value = resp;
      } catch (error) {
        throw new Error(error);
      }
    };
    const submit = async () => {
      if (clienteSelect.value !== 0 && monto.value !== 0) {
        try {
          const data = {
            idCliente: clienteSelect.value,
            monto: monto.value,
          };
          const reqs = await fetch(`${URLAPIPAGO}pagosclientesinsert`, {
            body: JSON.stringify(data),
            method: "post",
            headers: {
              "Content-Type": "application/json",
            },
          });
          const resp = await reqs.json();
          console.log(resp);
        } catch (error) {
          throw new Error(error);
        } finally {
          limpiarFormulario();
        }
      }
    };
    const limpiarFormulario = () => {
      clienteSelect.value = 0;
      monto.value = 0;
      cargaClientes();
      cargaPagos();
    };
    const decimalsWithCommas = (decimal) => {
      var num = Number(decimal);
      return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    };

    return {
      clientesOp,
      clienteSelect,
      monto,
      pagos,

      cargaClientes,
      submit,

      decimalsWithCommas,
    };
  },
};
</script>