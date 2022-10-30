<template>
  <table
    v-show="!toggleTable"
    class="w-full text-sm text-left text-gray-500 dark:text-gray-400"
  >
    <thead
      class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
    >
      <tr>
        <th scope="col" class="px-6 py-3">Nombre</th>
        <th scope="col" class="px-6 py-3">Telefono</th>
      </tr>
    </thead>
    <tbody>
      <tr
        class="bg-white border-b click hover:bg-gray-100 hover:text-black"
        v-for="cliente in clientes"
        :key="cliente.id"
        @click="consultarCliente(cliente.id)"
      >
        <td class="px-6 py-4">{{ cliente.nombre }}</td>
        <td class="px-6 py-4">{{ cliente.telefono }}</td>
      </tr>
    </tbody>
  </table>

  <table
    v-show="toggleTable"
    class="w-full text-sm text-left text-gray-500 dark:text-gray-400"
  >
    <thead class="text-xs text-white uppercase bg-gray-50 dark:bg-gray-700">
      <tr>
        <th scope="col" class="px-6 py-3">ID: {{ clientePagos?.id }}</th>
        <th scope="col" class="px-6 py-3" colspan="2">
          NOMBRE: {{ clientePagos?.nombre }}, Teléfono
          {{ clientePagos?.telefono }}, Último pago:
          {{ validaDate(clientePagos?.ultimoPago) }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr
        class="bg-white border-b"
        v-for="pago in clientePagos?.pagos"
        :key="pago?.id"
      >
        <th scope="row" class="px-6 py-4 whitespace-nowrap">{{ pago?.id }}</th>
        <td class="px-6 py-4">${{ decimalsWithCommas(pago?.monto) }}</td>
        <td class="px-6 py-4">{{ validaDate(pago?.fechaPago) }}</td>
      </tr>
    </tbody>
    <button
      @click="regresar"
      class="inline-flex top-mar justify-center py-2 px-4 border border-transparent shadow-sm text-sm rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none"
    >
      Regresar
    </button>
  </table>
</template>

<script>
import { onMounted, ref, computed, watchEffect } from "vue";
import { useStore } from "vuex";
import { decimalsWithCommas, validaDate } from "@/utils/";
import { UrlsApi } from "@/utils/";

const { URLAPI_CLIENTES } = UrlsApi();

export default {
  name: "TablaClientes",
  setup() {
    onMounted(() => {
      store.dispatch("listarClientesAsync");
    });
    const store = useStore();

    const toggleTable = ref(false);

    const clientes = computed(() => store.getters.clientes);
    const clientePagos = ref({});

    const consultarCliente = (id) => {
      watchEffect(async () => {
        try {
          const reqs = await fetch(`${URLAPI_CLIENTES}clientepagos/${id}`);
          const resp = await reqs.json();
          clientePagos.value = resp;
          toggleTable.value = true;
        } catch (error) {
          throw new Error(error);
        }
      });
    }   

    const regresar = () => {
      toggleTable.value = false;
    };

    return {
      clientes,
      clientePagos,
      toggleTable,

      consultarCliente,
      regresar,
      decimalsWithCommas,
      validaDate,
    };
  },
};
</script>

<style>
.top-mar {
  margin-top: 15px;
}
</style>